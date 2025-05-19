#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

const char *ssid = "SE Factory";
const char *password = "SE-F@tory1243%";
// const char *serverAddress = "http://192.168.1.5:8000";
const char *serverAddress = "http://54.75.66.192";


const char *deviceFCMToken = "dIg7CJYrRNeiBhJ4IjXpcP:APA91bGSnwRy4OFyRttKizzJjQWSMEVa_pekfbhDl3iZ554Ty-idkLXuc9jtyANxLPJjwVzrHmLw5s5utBnw3xRM-4qmXNJ545DKVHmBsnaQAW5j2iRbT-6isLxxsffp1Zz8ckuBNl0J";

int lastCoPercentage = 0.0;
int previousCoPercentage = 0.0;
int sensorPin = A0;
int coValue = 0;

int roomId = 1;

WiFiClient client;
HTTPClient http;

void setup()
{
    Serial.begin(115200);
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED)
    {
        delay(1000);
        Serial.println("Connecting to WiFi...");
    }
    Serial.println("Connected to WiFi");

    http.begin(client, serverAddress);

    createSensor(roomId);

    pinMode(sensorPin, INPUT);
}

void loop()
{
    coValue = analogRead(sensorPin);

    int coPercentage = map(coValue, 0, 1023, 0, 100);
    Serial.print("CO Level: ");
    Serial.print(coPercentage);
    Serial.println("%");

    if (abs(coPercentage - lastCoPercentage) >= 5.0)
    {
        updateLevel(roomId, coPercentage);
        lastCoPercentage = coPercentage;
    }
    if (coPercentage > 40.0 && previousCoPercentage <= 40.0)
    {
        sendFCMNotification(coPercentage, "CO Level Alert", "CO Level is sensitive it crossed 40% and now it is ");
    }

    if (coPercentage > 70.0 )
    {
        sendFCMNotification(coPercentage, "CO Level Alert", "CO Level is dangerous it crossed 70% and now it is ");
    }
    previousCoPercentage = coPercentage;

    delay(5000);
}

void createSensor(int roomId)
{
    String serverEndpoint = "/api/sensor";
    String sensorData = "room_id=" + String(roomId);

    http.begin(client, serverAddress + serverEndpoint);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");
    int httpResponseCode = http.POST(sensorData);

    Serial.print("HTTP Response Code: ");
    Serial.println(httpResponseCode);

    if (httpResponseCode == 200)
    {
        Serial.println("Sensor created successfully");
    }
    else
    {
        Serial.println("Failed to create sensor");
    }

    http.end();
}

void updateLevel(int roomId, int coPercentage)
{
    String serverEndpoint = "/api/sensor/updateLevel";
    String postData = "room_id=" + String(roomId) + "&co_level=" + String(coPercentage);

    http.begin(client, serverAddress + serverEndpoint);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");
    int httpResponseCode = http.POST(postData);

    Serial.print("HTTP Response Code: ");
    Serial.println(httpResponseCode);

    if (httpResponseCode == 200)
    {
        Serial.println("CO level updated successfully");
    }
    else
    {
        Serial.println("Failed to update CO level");
    }

    http.end();
}

void sendFCMNotification(int coPercentage, const String& title, const String& body)
{
    String serverEndpoint = "/api/send-notification";
     String jsonPayload = "{\"notification\":{"
                          "\"title\":\""+title+"\","
                          "\"body\":\""+body+String(coPercentage)+"%\""
                          "},"
                          "\"to\":\"" + String(deviceFCMToken) + "\"}";


    http.begin(client,serverAddress + serverEndpoint);
    http.addHeader("Content-Type", "application/json");

    int httpResponseCode = http.POST(jsonPayload);
    if (httpResponseCode == 200)
    {
        Serial.println("Notification sent successfully");
    }
    else
    {
        Serial.println("Failed to send notification");
    }

    http.end();
}

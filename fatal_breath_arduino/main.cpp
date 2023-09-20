#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

const char *ssid = "AMAN";
const char *password = "Aliz1966";
const char *serverAddress = "http://192.168.1.5:8000";

float lastCoPercentage = 0.0;
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

    float coPercentage = map(coValue, 0, 1023, 0, 100);
    Serial.print("CO Level: ");
    Serial.print(coPercentage);
    Serial.println("%");

    if (abs(coPercentage - lastCoPercentage) >= 5.0)
    {
        updateLevel(roomId, coPercentage);
        lastCoPercentage = coPercentage;
    }

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
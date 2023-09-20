#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

const char *ssid = "AMAN";
const char *password = "Aliz1966";
const char *serverAddress = "http://192.168.1.5:8000";

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
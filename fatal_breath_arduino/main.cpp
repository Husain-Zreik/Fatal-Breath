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
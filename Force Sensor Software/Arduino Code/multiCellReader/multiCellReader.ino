// Last Edited: 20200616 Ellande Tang
// Code Reads each cell in sequence and prints out reading, load cell number, and time from arduino clock
// Code assumes an Arduino mega or equivalent

// Includes appropriate package to interface with ADC chip
#include "HX711.h"

// HX711 circuit wiring
const int LOAD_DATA_1 = 38;
const int LOAD_SCK_1 = 39;

const int LOAD_DATA_2 = 40;
const int LOAD_SCK_2 = 41;

const int LOAD_DATA_3 = 42;
const int LOAD_SCK_3 = 43;

const int LOAD_DATA_4 = 44;
const int LOAD_SCK_4 = 45;

const int LOAD_DATA_5 = 46;
const int LOAD_SCK_5 = 47;

const int LOAD_DATA_6 = 48;
const int LOAD_SCK_6 = 49;

const int LOAD_DATA_7 = 50;
const int LOAD_SCK_7 = 51;

const int LOAD_DATA_8 = 52;
const int LOAD_SCK_8 = 53;

unsigned long time;

// Read only the first three chips
HX711 load1;
HX711 load2;
HX711 load3;
/*
HX711 load4;
HX711 load5;
HX711 load6;
HX711 load7;
HX711 load8;
*/

void setup() {
  Serial.begin(57600);
  load1.begin(LOAD_DATA_1, LOAD_SCK_1);
  load2.begin(LOAD_DATA_2, LOAD_SCK_2);
  load3.begin(LOAD_DATA_3, LOAD_SCK_3);
  /*
  load4.begin(LOAD_DATA_4, LOAD_SCK_4);
  load5.begin(LOAD_DATA_5, LOAD_SCK_5);
  load6.begin(LOAD_DATA_6, LOAD_SCK_6);
  load7.begin(LOAD_DATA_7, LOAD_SCK_7);
  load8.begin(LOAD_DATA_8, LOAD_SCK_8);
  */
}

void loop() {

  if (load1.is_ready()) {
    long reading = load1.read();
    Serial.print("1:");
    time = millis();
    Serial.print(time);
    Serial.print(":");
    Serial.println(reading);
  }
  //delay(25);
  if (load2.is_ready()) {
    long reading = load2.read();
    Serial.print("2:");
    time = millis();
    Serial.print(time);
    Serial.print(":");
    Serial.println(reading);
  }
  //delay(25);
  if (load3.is_ready()) {
    long reading = load3.read();
    Serial.print("3:");
    time = millis();
    Serial.print(time);
    Serial.print(":");
    Serial.println(reading);
  }
  //delay(25);

  /*
  if (load4.is_ready()) {
    long reading = load4.read();
    Serial.print("4:");
    time = millis();
    Serial.print(time);
    Serial.print(":");
    Serial.println(reading);
  }
  //delay(25);

  if (load5.is_ready()) {
    long reading = load5.read();
    Serial.print(reading);
    Serial.print(" ");
  }

  if (load6.is_ready()) {
    long reading = load6.read();
    Serial.print(reading);
    Serial.print(" ");
  }

  if (load7.is_ready()) {
    long reading = load7.read();
    Serial.print(reading);
    Serial.print(" ");
  }
  
  if (load8.is_ready()) {
    long reading = load8.read();
    Serial.println(reading);
  }
  */
  //delay(100);
  
}

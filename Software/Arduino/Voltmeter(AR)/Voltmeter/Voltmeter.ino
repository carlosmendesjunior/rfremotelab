// Octave to SPI
// Author: Carlos Mendes Junior
// TU/e - IC Group
// Date: 01/Feb/2021
//=================================================================//

#include <SPI.h>
#include "Wire.h"

#define EOL 10
#define EOW ' '

// Variable Definition - Communication
int bit_num = 1000;
int bit_count = 0;
char last_char = EOW;
char buffer1[10];
char buffer2[10];
char buffer3;

// Output Pins Definition - Attenuator
int pin_le = 3;
int pin_clk = 4;
int pin_data = 2;

void setup() {

  // Setting Serial Baud
  Serial.begin(9600);

  // Wait for PC Initialization
  while (last_char != '/') {
    last_char = get_nextChar();
  };

}

//=================================LOOP================================//
void loop() {

  // Local Variables
  char cmd;

  cmd = get_nextChar();

  switch (cmd) {

    // --> Get data from Octave and send it to the ADC (Voltmeter)
    case 'v':
      while ( (bit_count < bit_num) && (last_char != EOW) ) {
        last_char = get_nextChar();
        if (last_char != EOL && last_char != EOW) {
          buffer3 = last_char;
          signal_octave();
        }
      }
      signal_octave();
      voltmeter(buffer3);
      bit_count = 0;
      last_char = EOL;
      break;

    case EOL: // discard EOLs
      // Do nothing
      break;

    case EOW:   // discard end of word
      // Do nothing
      break;

    default:  // What the bleep?
      break;
  }
  
}

//=============================FUNCTIONS===============================//

char get_nextChar() {
  while (!Serial.available()) {};
  return (Serial.read());
}

void signal_octave(void) {
  Serial.write('c');
}

void voltmeter(char p) {
  unsigned int v; // 
  switch (p) {
    case '0':
      pinMode(A0, INPUT);
      v = analogRead(A0);
      break;
    case '1':
      pinMode(A1, INPUT);
      v = analogRead(A1);
      break;
    case '2':
      pinMode(A2, INPUT);
      v = analogRead(A2);
      break;
    case '3':
      pinMode(A3, INPUT);
      v = analogRead(A3);
      break;
    case '4':
      pinMode(A4, INPUT);
      v = analogRead(A4);
      break;
    case '5':
      pinMode(A5, INPUT);
      v = analogRead(A5);
      break;
    default:
      // Do nothing
      break;
  }
  Serial.print(v);
//  itoa(v, v_c, 5);
//  Serial.write(v_c[0]);
//  Serial.write(v_c[1]);
//  Serial.write(v_c[2]);
//  Serial.write(v_c[3]);
  //Serial.write('c');
}

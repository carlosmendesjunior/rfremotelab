// Octave to SPI
// Author: Carlos Mendes Junior
// TU/e - IC Group
// Date: 01/Feb/2021
//=================================================================//

#include <SPI.h>

#define EOL 10
#define EOW ' ' 

// Variables Definition
int bit_num = 1000;
int bit_count = 0;
char last_char = EOW;

// Output Pins Definition - DUT
const int clock_SPI = 17;    // A3
const int data_SPI = 16;     // A2
const int enable_SPI = 15;   // A1
const int shutdown_SPI = 14; // A0

// Output Pins Definition - Motherboard
const int pin_mot[] = {13,12,11,10,9,8,7,6,5,4,3,2,19,18,17,16}; // A5,A4,A3,A2

void setup() {

  // Setting Serial Baud
  Serial.begin(9600); 

  // Setting Pin - DUT
  pinMode(clock_SPI, OUTPUT);
  pinMode(data_SPI, OUTPUT);
  pinMode(enable_SPI, OUTPUT);
  pinMode(shutdown_SPI, OUTPUT);

  // Setting Pin - Motherboard
  for (int i = 0; i < 16; i++) {
    pinMode(pin_mot[i], OUTPUT);
  }

  // Reseting Output - Motherboard
  for (int i = 2; i < 16; i=i+4) {
    digitalWrite(pin_mot[i], HIGH);
  }
  for (int i = 3; i < 16; i=i+4) {
    digitalWrite(pin_mot[i], HIGH);
  }

  // Reseting Output - DUT
  digitalWrite(clock_SPI, HIGH);
  digitalWrite(data_SPI, HIGH);
  digitalWrite(enable_SPI, HIGH);
  digitalWrite(shutdown_SPI, HIGH);

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
    
    // Get data from Octave and send it (through SPI) to DUT
    case 'd': 
      digitalWrite(clock_SPI, LOW);
      digitalWrite(data_SPI, LOW);
      delay(4);
      digitalWrite(enable_SPI, LOW);
      while ( (bit_count < bit_num) && (last_char != EOW) ){
        last_char = get_nextChar();
        switch (last_char){
          case '0':
            digitalWrite(data_SPI, LOW);
            clock_out();
            bit_count++;
            signal_octave();
            break;
          case '1':
            digitalWrite(data_SPI, HIGH);
            clock_out();
            bit_count++;
            signal_octave();
            break;
          default:
            //last_char = EOW;
            break;
        }
      }
      signal_octave(); // THIS WAS ADDED
      digitalWrite(enable_SPI, HIGH);
      delay(4);
      digitalWrite(clock_SPI, HIGH);
      digitalWrite(data_SPI, HIGH);
      bit_count = 0;
      last_char = EOL;
      break;
      
    // --> Get data from Octave and send it (through Parallel) to the Motherboard 
    case 'm': 
      while ( (bit_count < bit_num) && (last_char != EOW) ){
        last_char = get_nextChar();
        switch (last_char){
          case '0':
            digitalWrite(pin_mot[bit_count], LOW);
            bit_count++;
            signal_octave();
            break;
          case '1':
            digitalWrite(pin_mot[bit_count], HIGH);
            bit_count++;
            signal_octave();
            break;
          default:
            //last_char = EOW;
            break;
        }
      }
      signal_octave(); // THIS WAS ADDED
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

void data_out(char data, int pin) {
  if (data == '0'){
    digitalWrite(pin, LOW);
  }
  else if (data == '1'){
    digitalWrite(pin, HIGH);
  }
  else{
    // Do nothing
  }
}

void clock_out(void) {
  delay(2); 
  digitalWrite(clock_SPI, HIGH);
  delay(2);
  digitalWrite(clock_SPI, LOW);
}

void signal_octave(void){
  Serial.write('c');
}

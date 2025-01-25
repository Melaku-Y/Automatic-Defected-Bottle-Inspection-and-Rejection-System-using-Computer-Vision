#define test 3
#define led 8
#define DC_motor 9
#define STEPPIN 4
#define DIRPIN 5
#define ENAPIN 6
int trigPin = 10;
int echoPin = 11;
int conveyor = 1;
int test_value;
int defect = 0 ;
const int STEPTIME = 5;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(STEPPIN,OUTPUT);
  pinMode(DIRPIN,OUTPUT);
  pinMode(ENAPIN,OUTPUT);
pinMode(DC_motor,OUTPUT);
pinMode(trigPin, OUTPUT);
pinMode(echoPin, INPUT);
pinMode(test, INPUT);
pinMode(led, OUTPUT);
}

void loop() {
 
  // put your main code here, to run repeatedly:
  if (conveyor == 1){
  //digitalWrite(DC_motor, HIGH);
  long duration, distance;
  digitalWrite(trigPin,HIGH);
  delayMicroseconds(1000);
  digitalWrite(trigPin, LOW);
  duration=pulseIn(echoPin, HIGH);
  distance =(duration/2)/29.1;
//  Serial.print(distance);
//  Serial.println("CM");
//  delay(10);
  if((distance<=10)) 
  {
//    digitalWrite(DC_motor, LOW);
//    delay(5000);
    digitalWrite(DC_motor, HIGH);
    delay(4000);
    digitalWrite(DC_motor, LOW);
    delay(2000);
    if (defect == 1){
   // if (digitalRead(test) == HIGH){
      digitalWrite(DC_motor, HIGH);
      delay(500);
        forward(60);
        delay(3500);
        reverse(60);
        delay(100);
      }
  }
   else if(distance>10)
  {
     digitalWrite(DC_motor, HIGH);
   }
  }
else{
  digitalWrite(DC_motor,LOW);
  }
}

void forward(int steps){
  int i;
  digitalWrite(ENAPIN,LOW);//ENABLE IS ACTIVE LOW
  digitalWrite(DIRPIN,HIGH);//SET DIRECTION 
  for(i=0;i<steps;i++){
    digitalWrite(STEPPIN,HIGH);
    delay(STEPTIME);
    digitalWrite(STEPPIN,LOW);
    delay(STEPTIME);
  }
  digitalWrite(ENAPIN,HIGH);//DISABLE STEPPER
}

void reverse(int steps){
  int i;
  digitalWrite(ENAPIN,LOW);//ENABLE IS ACTIVE LOW
  digitalWrite(DIRPIN,LOW);//SET DIRECTION 
  for(i=0;i<steps;i++){
    digitalWrite(STEPPIN,HIGH);
    delay(STEPTIME);
    digitalWrite(STEPPIN,LOW);
    delay(STEPTIME);
  }
  digitalWrite(ENAPIN,HIGH);//DISABLE STEPPER
}

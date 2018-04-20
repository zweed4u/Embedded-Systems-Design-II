// PID - Cascade Compensation Comparison
// CLICK IN THIS TEXT BOX. USE Ctrl-A, Ctrl-C TO COPY ALL.
// CLICK IN SKETCH. USE Ctrl-A, CTRL-V TO PASTE. SAVE. RUN.

const byte  TSAMP_MSEC = 10;
const float TSAMP = 0.001*TSAMP_MSEC;

//**********************************************************************

int tick = 0, refStartTick, dstrbStartTick, runTicks;
float cVel, cPos; // system kinematics
float refSpec, rPos, rVel, dstrbSpec, dstrb, vErr, pErr, Vctl;
float Kr = 1.0, Kp, Kv, Ki, pdC, pdD;
  
//**********************************************************************
void setup()
{
  Serial.begin(115200);
  Serial.println(F("Console line ending: 'Carriage return'.")); 
  Serial.println(F("\nControls 427: HW9 Cascade compensation")); 

  rPos = 0.0, rVel = 100.0, dstrb = 0.0;
  refSpec = 1.0, refStartTick = 1, runTicks = 600, dstrbStartTick = 300;
//  dstrbSpec = 0.001*23.0*(1.0/1.0)*(6.2/0.034); //N = 1
  dstrbSpec = 0.001*35.0*(1.0/3.0)*(6.2/0.034); //N = 3
//  dstrbSpec = 0.001*35.0*(1.0/9.0)*(6.2/0.034); //N = 9

  
//   PID configuration
//  pdC = 1.6, pdD = 12.0, Kp = 2.2, Ki = 1.5; // N = 1
  pdC = 2.7, pdD = 12.0, Kp = 2.2, Ki = 1.5; // N = 3
  pdC = 3.5, pdD = 12.0, Kp = 2.2, Ki = 1.5; // N = 9
  
  // Cascade configuration
//  Kp = 8.0, Kv = 0.27, Ki = 1.6; // N = 1
  Kp = 8.0, Kv = 0.15, Ki = 2.7; // N = 3
//  Kp = 8.0, Kv = 0.15, Ki = 3.5; // N = 9
  
}

//**********************************************************************
void loop()
{
  if (tick >= refStartTick) rPos += rVel*TSAMP;
  if (rPos > refSpec) rPos = refSpec;
  if (tick >= dstrbStartTick) dstrb = dstrbSpec;

  // PID
//  Vctl = Kp*pErr; // P loop
//  Vctl = PI_compensate(Vctl, Ki);
//  Vctl = PD_compensate(Vctl, pdC, pdD);
//  plantSimAB(Vctl+dstrb,cVel,cPos); // simulate plant responses
//  pErr = Kr*rPos - cPos;

  // PI cascade
  Vctl = Kv*vErr;
  Vctl = PI_compensate(Vctl,Ki);
  plantSimAB(Vctl+dstrb,cVel,cPos); // simulate plant responses
  pErr = Kr*rPos - cPos;
  vErr = Kp*pErr - cVel;
  
  displayData(); 
  if (++tick >= runTicks) while(true); // freeze process
    
} // loop()

//**********************************************************************
void plantSimAB(float x, float &vel, float &pos)
{  
//  const float a = 45, b = 1.6 ; //N = 1
  const float a = 77, b = 2.7; //N = 3
//  const float a = 97, b = 3.5; //N = 9
  
  // N = 1 -> 45/(s+1.6)
  // N = 3 -> 78/(s+2.7)
  // N = 9 -> 87/(s+3.5)
 
  float errV = a*x - b*vel; // accel = dvel/dt
  vel += errV*TSAMP; // integrate dvel/dt -> vel
  pos += vel*TSAMP;  // integrate vel = dpos/dt -> pos
}
//*******************************************************************
float PD_compensate(float x, float c, float d)
{
  // Proportional plus Derivative (Lead) compensator
  // Cancels pole at -c, replace with a pole at -d.
  // Compensator L = (s+c)/(s+d), Implement as 1 + (c-d)/(s+d). 

  static float yd = 0.0;
  
  yd += ((c-d)*x - d*yd)*TSAMP; 
  float y = x + yd;

  return y;
}
//*******************************************************************
float PI_compensate(float x, float Ki) 
{
  // Proportional plus Integral compensator
  // Cancels pole at location -Ki, replace with a pole at the origin.
  // Compensator L = (s+Ki)/s, Implement as 1 + Ki/s. 
  // Integrator output clamped to prevent 'wind up' memory.

  static float xi = 0.0;

  xi += x*TSAMP;
  float y = x + Ki * xi; // Y/X = 1 + Ki/s

  return (y);
}
//**********************************************************************
void displayData(void)
{   
  if (tick == 0)
  {
    Serial.println(F("\ntick\trPos\tvel\tpos"));
  }
  Serial.print(tick);   Serial.print('\t');
  Serial.print(rPos,3); Serial.print('\t');
  Serial.print(cVel,3); Serial.print('\t');
  Serial.print(cPos,3); Serial.print('\n');

} // displayData()


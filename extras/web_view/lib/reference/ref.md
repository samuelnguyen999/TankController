# Reference

## Tank loop and log

*TankController/src/UIState/MainMenu*

- **loop()** 58.h 285.cpp

*TankController/src/TankController*

- **loop()** 22.h 151.cpp
- **DataLogger** 165.cpp

```text
const __FlashStringHelper* header = F("time,tankid,temp,temp setpoint,pH,pH setpoint,onTime,Kp,Ki,Kd");

const __FlashStringHelper* format = F("%02i/%02i/%4i %02i:%02i:%02i, %3i, %s, %s, %s, %s, %4lu, %s, %s, %s");

time
tankid
char currentTemperatureString[10];
char thermalTarget[10];
char currentPhString[10];
char pHTarget[10];
onTime
char kp[12];
char ki[12];
char kd[12];


length = snprintf_P(buffer, sizeof(buffer), (PGM_P)format, (uint16_t)dtNow.month(), (uint16_t)dtNow.day(),
                      (uint16_t)dtNow.year(), (uint16_t)dtNow.hour(), (uint16_t)dtNow.minute(),
                      (uint16_t)dtNow.second(), (uint16_t)tankId, currentTemperatureString, thermalTarget,
                      currentPhString, pHTarget, (unsigned long)(millis() / 1000), kp, ki, kd);
```

*TankController/src/model/DataLogger*

## Alert Pusher (alert branch)

*TankController/src/model/AlertPusher*

- **sendPostRequest()**
- **format POST** 185.cpp

*TankController/src/TankController*

- **AlertPusher** 167.cpp
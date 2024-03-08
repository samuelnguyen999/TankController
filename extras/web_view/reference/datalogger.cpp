void DataLogger::writeToSD() {
  char currentTemperatureString[10];
  char currentPhString[10];
  if (TankController::instance()->isInCalibration()) {
    strscpy_P(currentTemperatureString, F("C"), sizeof(currentTemperatureString));
    strscpy_P(currentPhString, F("C"), sizeof(currentPhString));
  } else {
    floattostrf((float)ThermalProbe_TC::instance()->getRunningAverage(), 4, 2, currentTemperatureString,
                sizeof(currentTemperatureString));
    floattostrf((float)PHProbe::instance()->getPh(), 5, 3, currentPhString, sizeof(currentPhString));
  }
  DateTime_TC dtNow = DateTime_TC::now();
  PID_TC* pPID = PID_TC::instance();
  uint16_t tankId = EEPROM_TC::instance()->getTankID();
  char thermalTarget[10];
  char pHTarget[10];
  char kp[12];
  char ki[12];
  char kd[12];
  floattostrf(ThermalControl::instance()->getCurrentThermalTarget(), 4, 2, thermalTarget, sizeof(thermalTarget));
  floattostrf(PHControl::instance()->getCurrentTargetPh(), 5, 3, pHTarget, sizeof(pHTarget));
  floattostrf(pPID->getKp(), 8, 1, kp, sizeof(kp));
  floattostrf(pPID->getKi(), 8, 1, ki, sizeof(ki));
  floattostrf(pPID->getKd(), 8, 1, kd, sizeof(kd));
  const __FlashStringHelper* header = F("time,tankid,temp,temp setpoint,pH,pH setpoint,onTime,Kp,Ki,Kd");
  const __FlashStringHelper* format = F("%02i/%02i/%4i %02i:%02i:%02i, %3i, %s, %s, %s, %s, %4lu, %s, %s, %s");
  char header_buffer[64];
  strscpy_P(header_buffer, header, sizeof(header_buffer));
  int length;
  length = snprintf_P(buffer, sizeof(buffer), (PGM_P)format, (uint16_t)dtNow.month(), (uint16_t)dtNow.day(),
                      (uint16_t)dtNow.year(), (uint16_t)dtNow.hour(), (uint16_t)dtNow.minute(),
                      (uint16_t)dtNow.second(), (uint16_t)tankId, currentTemperatureString, thermalTarget,
                      currentPhString, pHTarget, (unsigned long)(millis() / 1000), kp, ki, kd);
  if ((length > sizeof(buffer)) || (length < 0)) {
    // TODO: Log a warning that string was truncated
    serial(F("WARNING! String was truncated to \"%s\""), buffer);
  }
  SD_TC::instance()->appendData(header_buffer, buffer);
}
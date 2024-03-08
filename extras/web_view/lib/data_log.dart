class DataLog {
  String time;
  int tankId; // uint16_t
  String currentTemperatureString; // char[10]
  String thermalTarget; // char[10]
  String currentPhString; // char[10]
  String pHTarget; // char[10]
  int onTime; // unsigned long
  String kp; // char[12]
  String ki; // char[12]
  String kd; // char[12]

  DataLog(
      this.time,
      this.tankId,
      this.currentTemperatureString,
      this.thermalTarget,
      this.currentPhString,
      this.pHTarget,
      this.onTime,
      this.kp,
      this.ki,
      this.kd);
}

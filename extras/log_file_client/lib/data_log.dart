class DataLog {
  String verision; //ex. 23.8.1-26-gbc65+
  int tankId; // uint16_t
  String severity; // 1 char
  String time; //ex. 2023-10-05 10:34:48
  String message; //unused
  String currentTemperatureString; // char[10]
  String thermalTarget; // char[10]
  int temperatureStdDev;
  String currentPhString; // char[10]
  String pHTarget; // char[10]
  int onTime; // unsigned long
  String macAdress;
  String kp; // char[12]
  String ki; // char[12]
  String kd; // char[12]

  DataLog(
      this.verision,
      this.tankId,
      this.severity,
      this.time,
      this.message,
      this.currentTemperatureString,
      this.thermalTarget,
      this.temperatureStdDev,
      this.currentPhString,
      this.pHTarget,
      this.onTime,
      this.macAdress,
      this.kp,
      this.ki,
      this.kd);
}

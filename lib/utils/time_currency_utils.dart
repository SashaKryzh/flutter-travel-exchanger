const kSecondsInHour = 3600;

double convertHourlyRateToSecondlyRate(double hourlyRate) {
  return hourlyRate / kSecondsInHour;
}

double convertSecondlyRateToHourly(double secondlyRate) {
  return secondlyRate * kSecondsInHour;
}

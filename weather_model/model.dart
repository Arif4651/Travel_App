class weatherdashboard {
  final double temp;
  final String weather;

  weatherdashboard({required this.temp, required this.weather});

  factory weatherdashboard.fromJson(Map<String, dynamic> json) {
    return weatherdashboard(
      temp: json['main']['temp'] - 273.15, // Convert Kelvin to Celsius
      weather: json['weather'][0]['main'],
    );
  }
}

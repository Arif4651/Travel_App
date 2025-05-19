class WeatherService {
  // PascalCase class name
  Future<Map<String, dynamic>> getCurrentWeather() async {
    // Example implementation
    return {'temp': 25.0, 'weather': 'Sunny', 'humidity': 60};
  }
}

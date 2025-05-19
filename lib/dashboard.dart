import 'package:travel_app/service/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/weather_model/model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _isLoading = true;
  String _errorMessage = '';

  Future<void> _fetchWeather() async {
    try {
      final city = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to get weather data: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Dashboard'), centerTitle: true),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _weather?.cityName ?? 'Unknown City',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(height: 20),
                        Icon(
                          _getWeatherIcon(),
                          size: 80,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${_weather?.temperature.round() ?? 0}°C',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _weather?.mainCondition ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }

  IconData _getWeatherIcon() {
    switch (_weather?.mainCondition?.toLowerCase()) {
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.umbrella;
      case 'clear':
        return Icons.wb_sunny;
      default:
        return Icons.device_thermostat;
    }
  }
}

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_app/weather_model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const String _apiKey = '5c051ca40bba448b9f8ae8814b002038';

  Future<Weather> getWeather(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_apiKey',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to load weather');
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}

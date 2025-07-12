import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:pacify_app/constants.dart';

class WeatherService {
  Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isEmpty) {
        throw Exception('Could not find coordinates for $cityName');
      }
      Location location = locations.first;
      double lat = location.latitude;
      double lon = location.longitude;

      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$openWeatherMapApiKey'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to load weather data: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching weather: $e');
      rethrow;
    }
  }
}
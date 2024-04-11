import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../model/weather_model.dart';
import 'package:http/http.dart' as https;

class WeatherService {
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather?appid=0297cad684b7bf233b470705ae56afcd';
  final String apiKey;

  WeatherService(this.apiKey);

  // This method fetches weather data for a given city name.
  Future<Weather> getWeather(String cityName) async {
    // Make an HTTP GET request to the OpenWeatherMap API.
    final response =
        await https.get(Uri.parse('$baseUrl&q=$cityName&units=metric'));

    // Check if the response status code is 200 (OK).
    if (response.statusCode == 200) {
      // If successful, parse the JSON response body into a Weather object.
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      // If unsuccessful, throw an exception.
      throw Exception('Failed to load weather data');
    }
  }

  // This method retrieves the current city based on the device's location.
  Future<String> getCurrentCity() async {
    // Check the location permission status.
    LocationPermission permission = await Geolocator.checkPermission();
    // If permission is denied, request it.
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Fetch the current device location.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Convert the location into a list of placemark objects.
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // Extract the city name from the first placemark.
    String? city = placemarks[0].locality;
    // Return the city name, if available, or an empty string.
    return city ?? "";
  }
}

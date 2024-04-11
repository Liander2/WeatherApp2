import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'service/weather_service.dart';
import 'model/weather_model.dart';
import 'package:logger/logger.dart';
//import 'package:intl/intl.dart';

final logger = Logger(); // Initialize logger instance

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('0297cad684b7bf233b470705ae56afcd');
  Weather? _weather;

  // Fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e, stacktrace) {
      logger.e('Error fetching weather',
          error: e, stackTrace: stacktrace); // Log error and stacktrace
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(); // Fetch weather data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather App'),
        backgroundColor: const Color.fromARGB(255, 118, 184, 238),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "Loading city...",
              style: const TextStyle(
                color: Color.fromRGBO(36, 35, 35, 1),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              '${_weather?.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(
                color: Color.fromRGBO(36, 35, 35, 1),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              _weather?.description ?? "Forecast",
              style: const TextStyle(
                color: Color.fromRGBO(36, 35, 35, 1),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              '🧊 ${_weather?.tempmin.toStringAsFixed(1)}°C',
              style: const TextStyle(
                color: Color.fromRGBO(36, 35, 35, 1),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              '🌡️ ${_weather?.tempmax.toStringAsFixed(1)}°C',
              style: const TextStyle(
                color: Color.fromRGBO(36, 35, 35, 1),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              '💨 ${_weather?.wind}M/S',
              style: const TextStyle(
                color: Color.fromRGBO(36, 35, 35, 1),
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

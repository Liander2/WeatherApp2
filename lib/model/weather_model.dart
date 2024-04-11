class Weather {
  final String cityName; // Name of the city
  final String description;
  final double temperature;
  final String icon;
  final double tempmin;
  final double tempmax;
  final double wind;

  // Constructor to initialize Weather object with required properties.
  Weather(
      {required this.cityName,
      required this.description,
      required this.temperature,
      required this.icon,
      required this.tempmin,
      required this.tempmax,
      required this.wind});

  // Factory method to create a Weather object from JSON data.
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'], // Extracting city name from JSON
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      tempmin: json['main']['temp_min'].toDouble(),
      tempmax: json['main']['temp_max'].toDouble(),
      wind: json['wind']['speed'].toDouble(),
    );
  }
}

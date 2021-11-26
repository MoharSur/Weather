class WeatherModel {
  // City Name
  String city;
  // County to which the city belongs
  String country;

  // Date
  num date;

  // Latitude and Longitudes of city
  num latitide;
  num longitude;

  num feelsLike; // FeelsLike Temperature
  num wind; // WindSpeed of the city
  num temperature; // Temperature of the city
  num minTemp; // Min temperature of the city
  num maxTemp; // Max temperature of the city
  num humidity; // Humidity of the city
  num pressure; // Pressure of the city

  String decription; // description of the Weather

  WeatherModel(
      {required this.city,
      required this.country,
      required this.latitide,
      required this.longitude,
      required this.temperature,
      required this.feelsLike,
      required this.wind,
      required this.maxTemp,
      required this.minTemp,
      required this.humidity,
      required this.pressure,
      required this.decription,
      required this.date});
  @override
  String toString() {
    return """ $city - $country - $date -
     $decription - $humidity - $latitide - 
     $longitude - $pressure - $temperature """;
  }
}

import 'dart:convert';

import 'package:http/http.dart';

import '../model/weather.dart';

class WeatherApi {
  final _apiKey = 'f16cd66a2f2013b42a27634ecebfdd9d';
  final _baseURL = 'https://api.openweathermap.org/data/2.5/';

  Future<WeatherModel> getWeatherDetails(String city) async {
    String address = '${_baseURL}weather?q=$city&appid=$_apiKey';
    Uri url = Uri.parse(address);

    Response response = await get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return _createWeatherModel(data, city);
    } else {
      throw Exception('Failed to fetch data ...');
    }
  }

  WeatherModel _createWeatherModel(var data, String _city) {
    // Latitide and Longitudes
    double _lon = data['coord']['lon'];
    double _lat = data['coord']['lat'];

    // Country of the city
    String _country = data['sys']['country'];

    // Description of weather
    String _description = data['weather'][0]['description'];

    int _temp = int.parse(_kToC(data['main']['temp']).round().toString());
    int _tempMin =
        int.parse(_kToC(data['main']['temp_min']).round().toString());
    int _tempMax =
        int.parse(_kToC(data['main']['temp_max']).round().toString());
    int _feelsLike =
        int.parse(_kToC(data['main']['feels_like']).round().toString());
    int _humidity = data['main']['humidity'];
    int _pressure = data['main']['pressure'];
    double _wind = double.parse(data['wind']['speed'].toString()).roundToDouble();

    // Date in Numeric format
    int _date = data['dt'];

    return WeatherModel(
        city: _city,
        country: _country,
        latitide: _lat,
        longitude: _lon,
        temperature: _temp,
        feelsLike: _feelsLike,
        wind: _wind,
        minTemp: _tempMin,
        maxTemp: _tempMax,
        humidity: _humidity,
        pressure: _pressure,
        decription: _description,
        date: _date);
  }

  double _kToC(double k) {
    return (k - 273.15);
  }
}

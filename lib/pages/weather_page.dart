import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


//This class is responsible for creating weather page
class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late String _apiKey;
  late String _city;
  late String _weather;
  late double _temperature;
  late int _humidity;
  late double _windSpeed;
  late Color _backgroundColor;

  // List of cities for the dropdown
  final List<String> _cities =  ['London', 'New York', 'Paris', 'Tokyo'];

  @override
  void initState() {
    super.initState();
    //personal api key
    _apiKey = 'a63fda2f51e3b336d632b12a8d44a4fd';
    _city = _cities[0]; // Default city
    _weather = '';
    _temperature = 0.0;
    _humidity = 0;
    _windSpeed = 0.0;
    _backgroundColor = Colors.blue; // Default background color

    _fetchWeather();
  }


  //Fetch weather from openweathermap and show errors when it fails to fatch the data
  Future<void> _fetchWeather() async {
    try {

      //openweathermap api
      final apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$_city&appid=$_apiKey&units=metric';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        //converting string that comes from api to json
        final data = json.decode(response.body);
        print('Weather Data: $data');
        setState(() {
          _weather = data['weather'][0]['main'];
          _temperature = data['main']['temp'].toDouble();
          _humidity = data['main']['humidity'];
          _windSpeed = data['wind']['speed'];
          _backgroundColor = _getBackgroundColor(_weather);
        });
      } else {
        print('Failed to load weather data. Status code: ${response.statusCode}');
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      throw Exception('Failed to load weather data');
    }
  }

  Color _getBackgroundColor(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'clear':
        return Colors.blue;
      case 'clouds':
        return Colors.grey;
      case 'rain':
        return Colors.indigo;
      case 'snow':
        return Colors.white;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Page'),
      ),
      body: Container(
        width: double.infinity,
        color: _backgroundColor,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown to select a city
            DropdownButton<String>(
              value: _city,
              onChanged: (value) {
                setState(() {
                  _city = value!;
                  _fetchWeather(); // Update weather data when the city changes
                });
              },
              items: _cities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text(
              'City: $_city',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Weather: $_weather',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Temperature: $_temperature°C',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Humidity: $_humidity%',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Wind Speed: $_windSpeed m/s',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

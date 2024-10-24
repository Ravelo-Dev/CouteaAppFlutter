import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClimaRD extends StatefulWidget {
  @override
  _ClimaRDState createState() => _ClimaRDState();
}

class _ClimaRDState extends State<ClimaRD> {
  String _description = '';
  double _temperature = 0.0;
  int _humidity = 0;
  double _windSpeed = 0.0;
  String _cityName = '';

  void _getWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=18.735693&lon=-70.162651&appid=53762dc723bf1a95573c3dc83f080694&lang=es'));
    final data = json.decode(response.body);
    setState(() {
      _description = data['weather'][0]['description'];
      _temperature = data['main']['temp'] - 273.15;
      _humidity = data['main']['humidity'];
      _windSpeed = data['wind']['speed'];
      _cityName = data['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clima')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.cloud),
                SizedBox(width: 10),
                Text('Descripción: $_description'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.thermometerHalf),
                SizedBox(width: 10),
                Text('Temperatura: ${_temperature.toStringAsFixed(1)}°C'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.tint),
                SizedBox(width: 10),
                Text('Humedad: $_humidity%'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.wind),
                SizedBox(width: 10),
                Text(
                    'Velocidad del viento: ${_windSpeed.toStringAsFixed(1)} m/s'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

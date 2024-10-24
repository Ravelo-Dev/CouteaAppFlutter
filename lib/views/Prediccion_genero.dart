import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrediccionGenero extends StatefulWidget {
  const PrediccionGenero({super.key});

  @override
  PrediccionGeneroState createState() => PrediccionGeneroState();
}

class PrediccionGeneroState extends State<PrediccionGenero> {
  final TextEditingController _controller = TextEditingController();
  String _genero = '';
  Color _color = Colors.white;

  void _predecirGenero(String nombre) async {
    try {
      final response =
          await http.get(Uri.parse('https://api.genderize.io/?name=$nombre'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _genero = data['gender'] ?? 'desconocido';
          _color = _genero == 'male'
              ? Colors.blue
              : (_genero == 'female' ? Colors.pink : Colors.grey);
        });
      } else {
        setState(() {
          _genero = 'error';
          _color = Colors.red;
        });
      }
    } catch (e) {
      setState(() {
        _genero = 'error';
        _color = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predicción de Género')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _predecirGenero(_controller.text),
              child: const Text('Predecir Género'),
            ),
            const SizedBox(height: 20),
            Container(
              color: _color,
              height: 170,
              width: 170,
              child: Center(
                child: _genero == 'error' ? Text('Error') : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

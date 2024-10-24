import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrediccionEdad extends StatefulWidget {
  const PrediccionEdad({super.key});

  @override
  _PrediccionEdadState createState() => _PrediccionEdadState();
}

class _PrediccionEdadState extends State<PrediccionEdad> {
  final TextEditingController _controller = TextEditingController();
  int _edad = 0;
  String _mensaje = '';
  String _imgURL = '';
  bool _isLoading = false;

  void _predecirEdad(String nombre) async {
    if (nombre.isEmpty) {
      setState(() {
        _mensaje = 'Por favor, ingresa un nombre';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response =
          await http.get(Uri.parse('https://api.agify.io/?name=$nombre'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _edad = data['age'];
          if (_edad < 18) {
            _mensaje = 'JOVEN';
            _imgURL = 'assets/images/Jovenes.jpg';
          } else if (_edad < 60) {
            _mensaje = 'ADULTO';
            _imgURL = 'assets/images/Adultos.jpg';
          } else {
            _mensaje = 'ANCIANO';
            _imgURL = 'assets/images/Ancianos.jpg';
          }
        });
      } else {
        setState(() {
          _mensaje = 'Error al obtener la predicción';
        });
      }
    } catch (e) {
      setState(() {
        _mensaje = 'Error de red';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predicción de Edad')),
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
                onPressed: () => _predecirEdad(_controller.text),
                child: const Text('Predecir Edad')),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      Text('Edad: $_edad'),
                      Text('Estado: $_mensaje'),
                      _imgURL.isNotEmpty
                          ? Image.asset(
                              _imgURL,
                              height: 180,
                              width: 180,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text('Error al cargar la imagen');
                              },
                            )
                          : Container(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

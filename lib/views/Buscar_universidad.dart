import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class PrediccionUniversidad extends StatefulWidget {
  const PrediccionUniversidad({super.key});

  @override
  _BuscarUniversidadState createState() => _BuscarUniversidadState();
}

class _BuscarUniversidadState extends State<PrediccionUniversidad> {
  final TextEditingController _controller = TextEditingController();
  List _universidades = [];

  void _BuscarUniversidades(String pais) async {
    if (pais.isEmpty) {
      setState(() {
        _universidades = [];
      });
      return;
    }

    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$pais'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _universidades = data;
      });
    } else {
      setState(() {
        _universidades = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error')),
      );
    }
  }

  void launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo iniciar $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Universidades')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'País'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _BuscarUniversidades(_controller.text),
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _universidades.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_universidades[index]['name'] ?? 'N/A'),
                    subtitle: Text(
                        _universidades[index]['domains']?.join(', ') ?? 'N/A'),
                    onTap: () => launchURL(
                        _universidades[index]['web_pages']?.first ?? ''),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

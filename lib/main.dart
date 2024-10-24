import 'package:couteau_app/views/About.dart';
import 'package:flutter/material.dart';
import 'views/Home.dart';
import 'views/Prediccion_genero.dart';
import 'views/Prediccion_edad.dart';
import 'views/Buscar_universidad.dart';
import 'views/Clima.dart';
import 'views/Wordpress_noticias.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CouteauTOOLs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
      routes: {
        '/genero': (context) => PrediccionGenero(),
        '/edad': (context) => PrediccionEdad(),
        '/universidad': (context) => PrediccionUniversidad(),
        '/clima': (context) => ClimaRD(),
        '/noticias': (context) => WordPressNoticias(),
        '/about': (context) => About(),
      },
    );
  }
}

import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Desarrollada por Ravelo-Dev')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/img2x2.jpeg'),
            ),
            SizedBox(height: 20),
            Text('Marcos M. Ravelo', style: TextStyle(fontSize: 24)),
            Text('Email: 20221947@itla.edu.do'),
            Text('Teléfono: 8297929978'),
          ],
        ),
      ),
    );
  }
}

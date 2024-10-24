import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Herramientas')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 1, 11, 63),
              ),
              child: Text('Menu', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Prediccion de Genero'),
              onTap: () {
                Navigator.pushNamed(context, '/genero');
              },
            ),
            ListTile(
              leading: Icon(Icons.cake),
              title: const Text('Prediccion de Edad'),
              onTap: () {
                Navigator.pushNamed(context, '/edad');
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: const Text('Buscar Universidad'),
              onTap: () {
                Navigator.pushNamed(context, '/universidad');
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud),
              title: const Text('Clima'),
              onTap: () {
                Navigator.pushNamed(context, '/clima');
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: const Text('Noticias de Billboard'),
              onTap: () {
                Navigator.pushNamed(context, '/noticias');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Image.network(
            'https://cdn-icons-png.flaticon.com/512/10476/10476858.png'),
      ),
    );
  }
}

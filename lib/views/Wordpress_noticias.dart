import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';

class WordPressNoticias extends StatefulWidget {
  @override
  _WordPressNoticiasState createState() => _WordPressNoticiasState();
}

class _WordPressNoticiasState extends State<WordPressNoticias> {
  List _news = [];

  void _fetchNews() async {
    final response = await http
        .get(Uri.parse('https://www.billboard.com/wp-json/wp/v2/posts'));
    final data = json.decode(response.body);
    setState(() {
      _news = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'lib/assets/images/Billboard-Logo.png', // Ruta del logo
              height: 70,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _news.length,
        itemBuilder: (context, index) {
          var unescape = HtmlUnescape();
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    unescape.convert(_news[index]['title']['rendered']),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Html(
                    data: _news[index]['excerpt']['rendered'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Publicado el: ${_news[index]['date']}',
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => launch(_news[index]['link']),
                    child: Text('Leer más'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

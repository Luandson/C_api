import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumindo API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Consumindo API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textfield = '';
  var response;
  String name = '';
  String price = '';

  static Future<Map> fetch(value) async {
    var url = Uri.parse(
        'https://api.hgbrasil.com/finance/stock_price?key=72dd99d7&symbol=$value');

    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var dado = Map.of(json['results']);
    return (dado[value.toString().toUpperCase()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            TextField(
              onChanged: (value) => setState(() => this.textfield = value),
              onSubmitted: (value) => setState(() => this.textfield = value),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Ação',
                hintText: 'Digite o título da ação',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  var dado = await fetch(textfield);
                  this.response = dado;
                  this.name = response['name'];
                  this.price = response['price'].toString();
                  setState(() {});
                },
                child: Text('Buscar')),
            Text(name == '' ? '' : 'Nome: $name, Preço: $price'),
          ],
        ),
      ),
    );
  }
}

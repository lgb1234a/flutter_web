import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '阿勒勒勒勒🐌的博客',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dataFromFile = "";
  Future<void> readText() async {
    final String response =
        await rootBundle.loadString('assets/papers/chenyn.txt');
    setState(() {
      dataFromFile = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    readText();
    return Scaffold(
      body: Markdown(data: dataFromFile, selectable: true),
      // body: FloatingActionButton(
      //   onPressed: () => {},
      //   child: const Image(image: AssetImage('assets/images/setting.png')),
      // ),
    );
  }
}

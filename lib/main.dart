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
    final String response = await rootBundle.loadString('assets/chenyn.md');
    setState(() {
      dataFromFile = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    String mdstring = """ 
    Markdown is the **best**!

    * It has lists.
    * It has [links - FlutterCampus.com](https://www.fluttercampus.com).
    * It has _so much more_...
    """;
    return Scaffold(
        body: Center(
      child: Markdown(data: mdstring, selectable: true),
    ));
  }
}

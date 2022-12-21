import 'package:flutter/material.dart';
import 'my_home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semi-final Hands-On',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(key: UniqueKey(), title: 'Semi-final Hands-on'),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:dsc/Layout/Home.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner :false,
      title: 'Maps',
      home: Home(),
    );
  }
}

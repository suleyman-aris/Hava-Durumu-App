import 'package:flutter/material.dart';
import 'package:hava_durumu_app/screens/loading_screen.dart';
import 'dart:js_interop';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Loading_Screen(),
    );
  }
}

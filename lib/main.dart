import 'package:flutter/material.dart';
import 'package:sen_restau/acceuil1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccueilPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:weather_app/networking.dart';

import 'package:weather_app/location_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late double latitude;
  late double longitude;
  NetworkHelper networkHelper = NetworkHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: LocationScreen());
  }
}

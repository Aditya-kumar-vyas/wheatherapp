import 'package:flutter/material.dart';
import 'package:wheatherapp/weather_screen.dart';

// quote in flutter constraints go down sizes go up and parent set position
void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const WeatherScreen(),
    );
  }
}

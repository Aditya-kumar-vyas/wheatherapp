import 'package:flutter/material.dart';

class hourlyForecastItem extends StatelessWidget {
  final String s1;
  final IconData icon;
  final String s2;
  const hourlyForecastItem(
      {super.key, required this.s1, required this.icon, required this.s2});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          width: 100,
          child: Column(
            children: [
              Text(
                s1,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Icon(
                icon,
                size: 32,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                s2,
                style: const TextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

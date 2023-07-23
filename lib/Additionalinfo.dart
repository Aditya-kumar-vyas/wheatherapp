import 'package:flutter/material.dart';

class Additionalinfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  // these are all dynamic variable which has to be declared before build methos

  const Additionalinfo(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});
  // required.this.. is call of constructor whenever class Additional life is called
  // these value has to be present

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(label),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

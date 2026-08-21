import 'package:flutter/material.dart';

class EventLogo extends StatelessWidget {
  final String assetPath;
  final double height;

  const EventLogo({
    super.key,
    required this.assetPath,
    this.height = 92,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}

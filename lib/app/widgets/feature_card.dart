import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String imagePath;
  final String text;
  const FeatureCard({super.key, required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 40),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

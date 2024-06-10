import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        1000 ~/ 10,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : Colors.grey,
            height: 1,
          ),
        ),
      ),
    );
  }
}

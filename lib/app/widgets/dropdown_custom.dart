import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropdownCustom extends StatelessWidget {
  final String label;
  final String hintText;
  final FontWeight? fontWeight;
  final dynamic value;
  final List<String> items;
  final void Function(dynamic) onChanged;
  final String? Function(dynamic)? validator;

  const DropdownCustom({
    super.key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    this.validator,
    this.fontWeight,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: fontWeight ?? FontWeight.normal),
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownButtonFormField(
          value: value,
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xff54B175),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

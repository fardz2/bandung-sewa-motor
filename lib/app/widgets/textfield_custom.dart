import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final FontWeight? fontWeight;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const TextFieldCustom({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.fontWeight,
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
        TextFormField(
          validator: validator,
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: const Color(0xff54B175),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
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
        ),
      ],
    );
  }
}

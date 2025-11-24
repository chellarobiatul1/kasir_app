import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  final String hint;
  final bool obscure;
  final TextEditingController controller;

  const RoundedInput({
    Key? key,
    required this.hint,
    this.obscure = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 12),
        ),
      ),
    );
  }
}

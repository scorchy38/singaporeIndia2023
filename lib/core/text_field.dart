import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {key,
      required this.hint,
      required this.iconName,
      required this.controller,
      this.obscureText = false,
      this.validator,
      this.keyboardType,
      this.inputFormatters});

  final String hint;
  final IconData iconName;
  final TextEditingController controller;
  final bool obscureText;
  final dynamic validator;
  final TextInputType? keyboardType;
  final dynamic inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.grey),
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          prefixIcon: Icon(iconName, color: Colors.grey, size: 18 ),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
          filled: true,
          hoverColor: Colors.grey,
          focusColor: Colors.grey,
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder),
    );
  }
}

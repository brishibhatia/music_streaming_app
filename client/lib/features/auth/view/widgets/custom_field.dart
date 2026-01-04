import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;

  final TextEditingController controller;
  final bool isObscureText;

  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        obscuringCharacter: '*',
        validator: (val) {
          if (val!.isEmpty) {
            return "$hintText is missing";
          }
          return null;
        },

        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

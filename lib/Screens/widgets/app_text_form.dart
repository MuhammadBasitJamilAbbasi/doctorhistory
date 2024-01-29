import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.labelText,
    required this.keyboardType,
    required this.controller,

  });


  final TextInputType keyboardType;
  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,

        decoration: InputDecoration(

          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
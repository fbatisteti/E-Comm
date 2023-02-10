import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool isSecret;

  const CustomTextfield({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.isSecret = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (val) {
        return (val == null || val.isEmpty)
          ? 'Enter your $hintText'
          : null;
      },
      maxLines: maxLines,
      obscureText: isSecret,
    );
  }
}
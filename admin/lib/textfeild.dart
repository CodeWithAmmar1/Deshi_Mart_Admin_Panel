import 'package:flutter/material.dart';

class Textfeild extends StatelessWidget {
  final dynamic controller;
  final String text;
  const Textfeild({super.key, required this.controller, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.green, width: 5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.black, width: 1)),
          label: Text("$text"),
          filled: true,
          fillColor: Colors.white),
    );
  }
}

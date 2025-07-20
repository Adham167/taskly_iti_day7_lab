import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.message, required this.controller});
  final String message;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:controller ,
      decoration: InputDecoration( 
        labelText: message,
        labelStyle:TextStyle(color: Colors.black)
      ),
    );
  }
}
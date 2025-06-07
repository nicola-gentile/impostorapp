import 'package:flutter/material.dart';
import 'package:impostorapp/utils/sizes.dart';

class TextInput extends StatelessWidget {
  final String hintText;
  final TextEditingController _controller = TextEditingController();

  get text => _controller.text;

  TextInput({
    super.key,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: fontSize
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
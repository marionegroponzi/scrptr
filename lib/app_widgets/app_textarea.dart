import 'package:flutter/material.dart';

class AppTextArea extends StatelessWidget {
  AppTextArea({
    Key? key,
    required this.borderColor,
    required this.controller,
  }) : super(key: key);

  final Color borderColor;
  String? text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        readOnly: true,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          fontFamily: 'RobotoMono',
          fontSize: 12,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }
}
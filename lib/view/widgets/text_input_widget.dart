import 'package:bdtok_prac/constrains.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final String myLabelText;
  final IconData myIcon;
  final TextEditingController controller;
  final bool isHide;

  const TextInputWidget(
      {super.key,
      required this.myLabelText,
      required this.myIcon,
      required this.controller, this.isHide = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        obscureText: isHide,
        decoration: InputDecoration(
          labelText: myLabelText,
          icon: Icon(
            myIcon,
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: borderColor, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        controller: controller,
      ),
    );
  }
}

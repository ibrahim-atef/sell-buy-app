import 'package:flutter/material.dart';

class AuthTextFromField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final Function validator;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? inputColor;
  int maxLines;
  bool enabled;

  AuthTextFromField({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.validator,
    required this.hintText,
    required this.textInputType,
    this.prefixIcon,
    this.inputColor,
    required this.suffixIcon,
    this.maxLines=1,
    this.enabled=true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(hintText);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textAlign: TextAlign.center,
      cursorColor: Colors.black,enabled: enabled,
      style: TextStyle(color: inputColor ?? Colors.black.withOpacity(0.6)),
      keyboardType: textInputType,
      validator: (value) => validator(value),
      maxLines:maxLines ,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: isArabic ? 'Amiri' : 'BonaNovaSC',
          color: inputColor ?? Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: const Color(0xff91bfc6),
        // Background color
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        // Adjust padding
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

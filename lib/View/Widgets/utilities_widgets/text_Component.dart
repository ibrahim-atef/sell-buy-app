import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;  // New fontStyle parameter
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);

    return Text(
      text,
      maxLines: 2,
      style: TextStyle(
        fontFamily: isArabic ? 'Rubik' : 'BonaNovaSC',
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle,  // Apply italic or normal font style
        decoration: textDecoration ?? TextDecoration.none,
      ),
    );
  }

  const TextComponent({
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight,
    this.fontStyle = FontStyle.normal, // Set normal as the default style
    this.textDecoration,
  });
}

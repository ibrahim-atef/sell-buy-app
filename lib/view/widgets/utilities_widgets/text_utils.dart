import 'package:flutter/material.dart';

class KTextUtils extends StatelessWidget {
  String text;
  double size;
  Color color;
  FontWeight fontWeight;
  TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);

    return Text(text,
        maxLines: 2,
        style: TextStyle(
            fontFamily: isArabic ? 'Amiri' : 'BonaNovaSC',
            fontSize: size,
            color: color,
            fontWeight: fontWeight,
            decoration: textDecoration ?? TextDecoration.none));
  }

  KTextUtils({
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight,
    this.textDecoration
  });
}

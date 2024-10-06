import 'package:flutter/material.dart';

class IconButtonComponent extends StatelessWidget {
  final String iconPath;     // The path to the icon image
  final String title;        // The text to display
  final Function() function;  // The function to call when tapped
  final double h;            // Height of the button
  final double w;            // Width of the button
  final Color shadowColor;
  final Color color;

  const IconButtonComponent({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.function,
    required this.h,
    required this.w,
    required this.color,
    this.shadowColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          color: color,  // Main button color
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(iconPath),  // Icon image
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

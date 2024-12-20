import 'package:sell_buy/utilities/themes.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final Function() onPressed;
  final Widget text;
  final double width;
  final Color? backgroundColor;
  final double? h;

  ButtonComponent({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.width,
    this.backgroundColor,
    this.h,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height:h==null? height * .06:h==0?null:h,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: backgroundColor ?? mainColor,

          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}

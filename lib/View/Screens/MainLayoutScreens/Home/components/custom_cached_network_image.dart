import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/themes.dart';



class CirculeImageAvatar extends StatelessWidget {
  final String imageUrl;
  final double width;
  final bool? isSelected;
  final File? image;
  final VoidCallback callback;

  const CirculeImageAvatar({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.isSelected,
    this.image,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected! ? mainColor:Colors.transparent,
          width: 1.8,
        ),
      ),
      child: Card(
        margin: EdgeInsets.all(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: callback,
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: "assets/Icons/loader.gif",
              image: imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}

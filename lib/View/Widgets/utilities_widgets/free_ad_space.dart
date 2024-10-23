import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Routes/routes.dart';
import 'package:sell_buy/Utilities/themes.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

class FreeAdSpace extends StatelessWidget {
  final double width;
  final double height;

  const FreeAdSpace({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.selectTypeOfAdScreen);
      },
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(color: baseColorShimmer, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ]),
        child: Center(
          child: TextComponent(
              text: "Free Ad Space".tr,
              size: 14,
              color: Colors.black54,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

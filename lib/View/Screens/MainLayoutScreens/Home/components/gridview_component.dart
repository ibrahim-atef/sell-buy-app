import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_shimmer_widget.dart';

class HomeGridViewComponents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),   shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return  Text(" refresh");
          }),
    );
  }
}

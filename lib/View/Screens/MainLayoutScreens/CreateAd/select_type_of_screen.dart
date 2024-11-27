import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Routes/routes.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/Utilities/themes.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/button_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import 'external_screens/add_ad_extra_details.dart';

class SelectTypeOfAdScreen extends StatelessWidget {
  const SelectTypeOfAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            IconBroken.Close_Square,
            color: black,
          ),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonComponent(
              onPressed: () {
                  Get.toNamed(Routes.CreateAdScreen);

              },
              text: TextComponent(
                  text: "Create Ad".tr,
                  size: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
              width: Get.width * .6,
              backgroundColor: baseColorShimmer,
              h: Get.width * .3,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonComponent(
              onPressed: () {
                Get.toNamed(Routes.createCommercialAdScreen);
              },
              text: TextComponent(
                  text: "Create Commercials Ad".tr,
                  size: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
              width: Get.width * .6,
              h: Get.width * .3,
              backgroundColor: baseColorShimmer,
            ),
          ],
        ),
      ),
    );
  }
}

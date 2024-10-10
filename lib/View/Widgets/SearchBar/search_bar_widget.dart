import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/icons.dart';

import '../../../Controllers/home_controller.dart';
import '../utilities_widgets/custom_text_from_field.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomTextFromField(
        hintText: 'Search'.tr,
        prefixIcon: const Icon(
          IconBroken.Search,
          size: 20,
          color: Colors.grey,
        ),
        validator: (value) {},

        // Using the controller from homeController
        controller: homeController.searchController,
        textInputType: TextInputType.text,
        obscureText: false,
        maxLines: 1,
        enabled: true,
        inputColor: Colors.black54,

        // Conditionally show close icon if there's text
        suffixIcon: homeController.searchText.isEmpty
            ? null
            : IconButton(
                onPressed: () {
                  // Clear the text when the close icon is pressed
                  homeController.clearSearchQuery();
                },
                icon: const Icon(IconBroken.Close_Square),
              ),
      );
    });
  }
}

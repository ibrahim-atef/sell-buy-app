import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../../Controllers/subcategories_controller.dart';
import '../../../../../Utilities/constants.dart';


class LocationFiltersBar extends StatefulWidget {
  LocationFiltersBar({super.key});

  @override
  State<LocationFiltersBar> createState() => _LocationFiltersBarState();
}

class _LocationFiltersBarState extends State<LocationFiltersBar> {
  final subCategoriesController = Get.put(SubCategoriesController());

  List<Function(BuildContext)> get tabFunctions => [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.07,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: saudiLocations.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildFilterItem(
            context: context,
            title: Get.locale!.languageCode == "en"
                ? saudiLocations[index].enName
                : saudiLocations[index].arName,
            onTap: () => tabFunctions[index](context),
          );
        },
      ),
    );
  }

  Widget _buildFilterItem({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.05,
        margin: const EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            TextComponent(
              text: title.tr,
              color: Colors.black,
              size: 14,
              fontWeight: FontWeight.w600,
            ),

          ],
        ),
      ),
    );
  }

  Widget buildSB() {
    return SizedBox(height: Get.height * .01);
  }
}

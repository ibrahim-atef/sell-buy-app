import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Home/SubCategories/FiltersScreens/year_of_production_screen.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../../Controllers/subcategories_controller.dart';
  import '../SubCategories/FiltersScreens/all_filters_screen.dart';
 import '../SubCategories/FiltersScreens/vehicle_type_screen.dart';

class RentalCarFiltersBarSection extends StatefulWidget {
  RentalCarFiltersBarSection({super.key});

  @override
  State<RentalCarFiltersBarSection> createState() => _RentalCarFiltersBarSectionState();
}

class _RentalCarFiltersBarSectionState extends State<RentalCarFiltersBarSection> {
  final List<String> filterOptions = [
    "AllFilters",
    "vehicleType",

  ];
  final subCategoriesController = Get.put(SubCategoriesController());


  List<Function(BuildContext)> get tabFunctions => [
        (context) =>
        Get.to(AllFiltersScreen(), transition: Transition.rightToLeft),
        (context) =>  Get.to(VehicleTypeScreen(), transition: Transition.rightToLeft),

  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.07,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: filterOptions.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildFilterItem(
            context: context,
            title: filterOptions[index],
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
            SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
              size: 18,
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

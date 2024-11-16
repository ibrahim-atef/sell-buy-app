import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Home/SubCategories/FiltersScreens/year_of_production_screen.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../../Controllers/subcategories_controller.dart';
import '../../../../../utilities/themes.dart';
import '../../../../Widgets/utilities_widgets/button_component.dart';
import '../../../../Widgets/utilities_widgets/custom_text_from_field.dart';
import '../SubCategories/FiltersScreens/all_filters_screen.dart';
import '../SubCategories/FiltersScreens/brand_filters_screen.dart';
import '../SubCategories/FiltersScreens/storage_capacity_scren.dart';
import '../SubCategories/FiltersScreens/vehicle_type_screen.dart';

class ElectronicsFilterBar extends StatefulWidget {
  ElectronicsFilterBar({super.key});

  @override
  State<ElectronicsFilterBar> createState() => _ElectronicsFilterBarState();
}

class _ElectronicsFilterBarState extends State<ElectronicsFilterBar> {
  final List<String> filterOptions = [
    "AllFilters",
    "type",
    "price",
    "storageCapacity",
    "condition"
  ];
  final subCategoriesController = Get.put(SubCategoriesController());
  void _openPriceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: Get.height * .33,
          child: Card(
            margin: EdgeInsets.all(0),
            elevation: .2,
            color: Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){Get.back();}, icon: Icon(IconBroken.Close_Square))
                      ,TextComponent(
                        text: "price".tr,
                        size: 22,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: .4,
                    color: Colors.grey[400],
                  ),
                  buildSB(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: Get.width * .4,
                        height: Get.height * .07,
                        child: CustomTextFromField(
                          controller:
                          subCategoriesController.minPriceController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the price'.tr;
                            }
                          },
                          hintText: subCategoriesController.minPrice.toString(),
                          textInputType: TextInputType.number,
                          suffixIcon: null,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * .4,
                        height: Get.height * .07,
                        child: CustomTextFromField(
                          controller:
                          subCategoriesController.maxPriceController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the price'.tr;
                            }
                          },
                          hintText: "300000",
                          textInputType: TextInputType.number,
                          suffixIcon: null,
                        ),
                      ),
                    ],
                  ),
                  ButtonComponent(
                    onPressed: () {
                      Get.back();
                    },
                    text: TextComponent(
                        text: "viewResults".tr,
                        size: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    width: Get.width * .9,
                    backgroundColor: mainColor,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  List<Function(BuildContext)> get tabFunctions => [
        (context) =>
            Get.to(AllFiltersScreen(), transition: Transition.rightToLeft),
        (s) {},
        (context)  => _openPriceModal(context),
        (s) {
          Get.to(StorageCapacityScreen(), transition: Transition.rightToLeft);
        },
        (s) {}
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

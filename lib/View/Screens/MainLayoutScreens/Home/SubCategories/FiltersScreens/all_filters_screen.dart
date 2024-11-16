import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Home/SubCategories/FiltersScreens/type_of_gas_screen.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Home/SubCategories/FiltersScreens/year_of_production_screen.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Profile/profile_screen.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/button_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_text_from_field.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../../../Controllers/subcategories_controller.dart';
import '../../../../../../Utilities/themes.dart';
import 'brand_filters_screen.dart';

class AllFiltersScreen extends StatelessWidget {
  AllFiltersScreen({super.key});

  final subCategoriesController = Get.put(SubCategoriesController());
  List<String> roofHatchOptions = [
    "All",
    "NoRoof",
    "Normal",
    "Panorama",
  ];
  List<String> InnerColorsOptions = [
    "black",
    "white",
    "tan",
    "beige",
    "gray",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        title: TextComponent(
          text: "AllFilters".tr,
          size: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Get.locale?.languageCode == 'en'
              ? IconBroken.Arrow___Left_2
              : IconBroken.Arrow___Right_2),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: TextComponent(
              text: "Reset".tr,
              size: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black45,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSB(),
              buildOptionItem(null, "Brand".tr, () { Get.to(BrandFiltersScreen(), transition: Transition.rightToLeft); },
                  hasDivider: false, height: Get.height * .05),
              buildSB(),
              _buildPriceSection(),
              buildSB(),
              buildOptionItem(null, "YearOfProduction".tr, () { Get.to(YearOfProductionScreen(), transition: Transition.rightToLeft);},
                  hasDivider: false, height: Get.height * .05),
              buildSB(),
              _buildRoofHatchSection(),
              buildSB(),
              _buildCounterSection(),
              buildSB(),
              buildOptionItem(null, "OuterColor".tr, () {},
                  hasDivider: false, height: Get.height * .05),
              buildSB(),
              buildOptionItem(null, "FuelType".tr, () {Get.to(TypeOfGasScreen(), transition: Transition.rightToLeft);},
                  hasDivider: false, height: Get.height * .05),
              buildSB(),
              buildOptionItem(null, "TypeOfCylinders".tr, () {},
                  hasDivider: false, height: Get.height * .05),
              buildSB(),
              buildOptionItem(null, "GearBoxType".tr, () {},
                  hasDivider: false, height: Get.height * .05),
              buildSB(),
              _buildInnerColorsSection(),
              buildSB(),
              SpecificationsComponent(),
              SizedBox(height: Get.height * .1),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFloatingButton(),
    );
  }

  Widget buildSB() {
    return SizedBox(height: Get.height * .01);
  }

  Widget buildFloatingButton() {
    return ButtonComponent(
      onPressed: () { Get.back();},
      text: TextComponent(
          text: "viewResults".tr,
          size: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold),
      width: Get.width * .9,
      backgroundColor: mainColor,
    );
  }

  Widget _buildCounterSection() {
    return Card(
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
          children: [
            TextComponent(
              text: "Counter".tr,
              size: 18,
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),
            buildSB(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: Get.width * .4,
                  height: Get.height * .07,
                  child: CustomTextFromField(
                      controller: subCategoriesController.minPriceController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the price'.tr;
                        }
                      },
                      hintText: subCategoriesController.minPrice.toString(),
                      textInputType: TextInputType.number,
                      suffixIcon: null),
                ),
                SizedBox(
                  width: Get.width * .4,
                  height: Get.height * .07,
                  child: CustomTextFromField(
                      controller: subCategoriesController.maxPriceController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the price'.tr;
                        }
                      },
                      hintText: "300000",
                      textInputType: TextInputType.number,
                      suffixIcon: null),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection() {
    return Card(
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
          children: [
            TextComponent(
              text: "price".tr,
              size: 18,
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),
            buildSB(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: Get.width * .4,
                  height: Get.height * .07,
                  child: CustomTextFromField(
                      controller: subCategoriesController.minPriceController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the price'.tr;
                        }
                      },
                      hintText: subCategoriesController.minPrice.toString(),
                      textInputType: TextInputType.number,
                      suffixIcon: null),
                ),
                SizedBox(
                  width: Get.width * .4,
                  height: Get.height * .07,
                  child: CustomTextFromField(
                      controller: subCategoriesController.maxPriceController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the price'.tr;
                        }
                      },
                      hintText: subCategoriesController.maxPrice.toString(),
                      textInputType: TextInputType.number,
                      suffixIcon: null),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRoofHatchSection() {
    return Card(
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
          children: [
            TextComponent(
              text: "roofHatch".tr,
              size: 18,
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),
            buildSB(),
            SizedBox(
              height: 50,
              width: Get.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: roofHatchOptions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: ChoiceChip(
                      label: TextComponent(
                          text: roofHatchOptions[index].tr,
                          color: Colors.black,
                          size: 13,
                          fontWeight: FontWeight.bold),
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blue[200],
                      selected: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (bool selected) {},
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInnerColorsSection() {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300), // Grey border
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            TextComponent(
              text: "InnerColor".tr,
              size: 18,
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),
            SizedBox(height: 8),
            buildSB(),
            SizedBox(height: 16),

            // Inner color containers
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: InnerColorsOptions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: GestureDetector(
                      onTap: () {
                        // Handle selection state here
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white, // Default background color
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.grey.shade300, // Grey border for each item
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [

                            TextComponent(
                              text: InnerColorsOptions[index].tr,
                              color: Colors.black87,
                              size: 13,
                              fontWeight: FontWeight.w500,
                            ), SizedBox(width: 4),  Checkbox(
                              value: false, // Set your selection logic here
                              onChanged: (value) {},
                              activeColor: Colors.blue[200],
                              checkColor: Colors.white,
                              side: BorderSide(color: Colors.grey.shade400),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}


class SpecificationsComponent extends StatefulWidget {
  @override
  _SpecificationsComponentState createState() =>
      _SpecificationsComponentState();
}

class _SpecificationsComponentState extends State<SpecificationsComponent> {
  // List of specifications in English
  final List<String> specificationsOptions = [
    "Full Specifications",
    "Agency",
    "Under Warranty",
    "Inspected",
    "Front Airbags",
    "Side Airbags",
    "Sensor",
    "Auto Parking",
    "Navigation",
    "Alarm System",
    "Bluetooth",
    "Seat Heating Control",
    "Fast Selling",
    "Insured",
  ];

  // Keep track of which options are selected
  final Map<String, bool> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    // Initialize all options as unselected
    for (var option in specificationsOptions) {
      selectedOptions[option] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            TextComponent(
              text: "Specifications".tr,
              size: 18,
              fontWeight: FontWeight.bold,
              color: mainColor,
              ),

            SizedBox(height: 12),

            // Grid of options
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: specificationsOptions.map((option) {
                return ChoiceContainer(
                  label: option.tr,
                  selected: selectedOptions[option]!,
                  onSelected: (isSelected) {
                    setState(() {
                      selectedOptions[option] = isSelected;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom container widget for each choice
class ChoiceContainer extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const ChoiceContainer({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(!selected),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.blue[100] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            TextComponent(

                text: label.tr, size : 13,
                color: Colors.black87,
                fontWeight: FontWeight.w500,

            ),          SizedBox(width: 4),  Checkbox(
              value: selected,
              onChanged: (value) => onSelected(value!),
              activeColor: Colors.blue[200],
              checkColor: Colors.white,
              side: BorderSide(color: Colors.grey.shade400),
            ),

          ],
        ),
      ),
    );
  }
}

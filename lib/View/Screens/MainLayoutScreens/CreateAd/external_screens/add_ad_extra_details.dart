import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Profile/profile_screen.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../../Utilities/icons.dart';
import '../../../../../Utilities/themes.dart';
import '../../../../Widgets/utilities_widgets/button_component.dart';
import '../../Home/SubCategories/FiltersScreens/brand_filters_screen.dart';
import '../../Home/SubCategories/FiltersScreens/type_of_gas_screen.dart';
import '../../Home/SubCategories/FiltersScreens/year_of_production_screen.dart';

class AddAdExtraDetails extends StatefulWidget {
  const AddAdExtraDetails({super.key});

  @override
  State<AddAdExtraDetails> createState() => _AddAdExtraDetailsState();
}

class _AddAdExtraDetailsState extends State<AddAdExtraDetails> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to handle input fields
  String? selectedYear = "YearOfProduction";

  String? selectedOuterColor = "OuterColor";

  String? selectedBrand = "Brand";
  String? selectedFuel = "FuelType";

  TextEditingController carCounterController = TextEditingController();
  TextEditingController cylindersController = TextEditingController();
  TextEditingController fullSpecificationsController = TextEditingController();

  String? selectedCylinders;

  List<String> cylinderTypes = ['4', '6', '8', '10'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
            text: "Add Extra Details".tr,
            size: 18,
            color: Colors.black54,
            fontWeight: FontWeight.bold),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Get.locale?.languageCode == 'en'
              ? IconBroken.Arrow___Left_2
              : IconBroken.Arrow___Right_2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: .5),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(0),
                child:
                    buildOptionItem(null, selectedYear.toString().tr, () async {
                  selectedYear = await Get.to(() => YearOfProductionScreen());
                  setState(() {});
                }, hasDivider: false, height: Get.height * .05),
              ),
              SizedBox(height: 10),

              // Car Counter
              TextFormField(
                controller: carCounterController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Counter".tr,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the car counter";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Brand

              Container(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: .5),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(0),
                child: buildOptionItem(null, selectedBrand.toString().tr,
                    () async {
                  selectedBrand  = await Get.to(() => BrandFiltersScreen());
                  setState(() {});
                }, hasDivider: false, height: Get.height * .05),
              ),
              SizedBox(height: 10),

              // Outer Color
              Container(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: .5),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(0),
                child:
                    buildOptionItem(null, selectedFuel.toString().tr, () async {
                  selectedFuel = await Get.to(() => TypeOfGasScreen());
                }, hasDivider: false, height: Get.height * .05),
              ),
              SizedBox(height: 10),

              // Fuel Type
              Container(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: .5),
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(0),
                child: buildOptionItem(
                    null, selectedOuterColor.toString().tr, () async {},
                    hasDivider: false, height: Get.height * .05),
              ),
              SizedBox(height: 10),

              // Type of Cylinders
              DropdownButtonFormField<String>(
                value: selectedCylinders,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCylinders = newValue;
                  });
                },
                items: cylinderTypes.map((cylinder) {
                  return DropdownMenuItem<String>(
                    value: cylinder,
                    child: Text(cylinder),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "TypeOfCylinders".tr,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please select the number of cylinders";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Full Specifications
              TextFormField(
                controller: fullSpecificationsController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Full Specifications".tr,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide the full specifications";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Submit Button

              ButtonComponent(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Process the data
                    print("Form is valid");
                    Navigator.pop(context, true );
                    // You can submit the form here or perform any other action
                  } else {
                    print("Form is invalid");
                  }
                },
                text: TextComponent(
                    text: "Create AD".tr,
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
  }
}

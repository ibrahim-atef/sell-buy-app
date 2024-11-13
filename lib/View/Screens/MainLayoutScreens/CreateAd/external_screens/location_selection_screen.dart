import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Model/location_model.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/button_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../../Utilities/constants.dart';

class LocationSelectionScreen extends StatefulWidget {
  @override
  _LocationSelectionScreenState createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  // Variables to store selected items
  Governorate? selectedGovernorate;
  Region? selectedRegion;
  District? selectedDistrict;

  // Lists to store regions and districts based on selected Governorate/Region
  List<Region> regions = [];
  List<District> districts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: "Select Location".tr,
          size: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Governorate Dropdown
            DropdownButtonFormField<Governorate>(
              value: selectedGovernorate,
              items: saudiLocations.map((gov) {
                return DropdownMenuItem<Governorate>(
                  value: gov,
                  child: Text(Get.locale?.languageCode == 'ar' ? gov.arName : gov.enName),
                );
              }).toList(),
              onChanged: (Governorate? value) {
                setState(() {
                  selectedGovernorate = value;
                  selectedRegion = null;
                  selectedDistrict = null;
                  regions = value?.regions ?? [];
                  districts = [];
                });
              },
              decoration: InputDecoration(labelText: "Governorate".tr),
            ),
            const SizedBox(height: 20),

            // Region Dropdown
            DropdownButtonFormField<Region>(
              value: selectedRegion,
              items: regions.map((region) {
                return DropdownMenuItem<Region>(
                  value: region,
                  child: Text( Get.locale?.languageCode == 'ar' ? region.nameAr : region.nameEn),
                );
              }).toList(),
              onChanged: (Region? value) {
                setState(() {
                  selectedRegion = value;
                  selectedDistrict = null;
                  districts = value?.districts ?? [];
                });
              },
              decoration: InputDecoration(labelText: "Region".tr),
            ),
            const SizedBox(height: 20),

            // District Dropdown
            DropdownButtonFormField<District>(
              value: selectedDistrict,
              items: districts.map((district) {
                return DropdownMenuItem<District>(
                  value: district,
                  child: Text( Get.locale?.languageCode == 'ar' ? district.nameAr : district.nameEn),
                );
              }).toList(),
              onChanged: (District? value) {
                setState(() {
                  selectedDistrict = value;
                });
              },
              decoration: InputDecoration(labelText: "District".tr),
            ),
            const SizedBox(height: 20),

            // Confirm Button
            Spacer(),
            ButtonComponent(
              onPressed: () {
                if (selectedGovernorate == null ||
                    selectedRegion == null ||
                    selectedDistrict == null) {
                  Get.snackbar("Error".tr, "Please select all fields".tr);
                  return;
                }

                Navigator.pop(context, {
                  "governorate": selectedGovernorate,
                  "region": selectedRegion,
                  "district": selectedDistrict,
                });
              },
              text: TextComponent(
                text: "Confirm".tr,
                size: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              width: Get.width * .7,
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

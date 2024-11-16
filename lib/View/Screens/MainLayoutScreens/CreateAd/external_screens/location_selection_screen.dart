import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Model/location_model.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/button_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';
import '../../../../../Utilities/constants.dart';
import '../../../../../Utilities/icons.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
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
        child: Column(
          children: [
            // Governorate Dropdown
            _buildDropdownButtonFormField<Governorate>(
              label: "Governorate".tr,
              value: selectedGovernorate,
              items: saudiLocations.map((gov) {
                return DropdownMenuItem<Governorate>(
                  value: gov,
                  child: Text(Get.locale?.languageCode == 'ar'
                      ? gov.arName
                      : gov.enName),
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
            ),
            const SizedBox(height: 20),

            // Region Dropdown
            _buildDropdownButtonFormField<Region>(
              label: "Region".tr,
              value: selectedRegion,
              items: regions.map((region) {
                return DropdownMenuItem<Region>(
                  value: region,
                  child: Text(Get.locale?.languageCode == 'ar'
                      ? region.nameAr
                      : region.nameEn),
                );
              }).toList(),
              onChanged: (Region? value) {
                setState(() {
                  selectedRegion = value;
                  selectedDistrict = null;
                  districts = value?.districts ?? [];
                });
              },
            ),
            const SizedBox(height: 20),

            // District Dropdown
            _buildDropdownButtonFormField<District>(
              label: "District".tr,
              value: selectedDistrict,
              items: districts.map((district) {
                return DropdownMenuItem<District>(
                  value: district,
                  child: Text(Get.locale?.languageCode == 'ar'
                      ? district.nameAr
                      : district.nameEn),
                );
              }).toList(),
              onChanged: (District? value) {
                setState(() {
                  selectedDistrict = value;
                });
              },
            ),
            const SizedBox(height: 20),

            Spacer(),

            // Confirm Button
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

  // Custom method to build styled DropdownButtonFormField
  Widget _buildDropdownButtonFormField<T>({
    required String label,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black87, width: 1.5),
        ),
      ),
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      iconEnabledColor: Colors.black87,
      dropdownColor: Colors.white,
      elevation: 3,
    );
  }
}

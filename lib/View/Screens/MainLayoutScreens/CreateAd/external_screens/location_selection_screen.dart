import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/button_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';
import '../../../../../Utilities/constants.dart';

class LocationSelectionScreen extends StatefulWidget {
  @override
  _LocationSelectionScreenState createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  String? selectedGovernorate;
  String? selectedRegion;
  String? selectedDistrict;

  // This method returns the governorate list based on the locale
  List<String> get governorates {
    bool isArabic(String text) {
      // Check if the text contains any Arabic characters
      return RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    }

    if (Get.locale?.languageCode == "ar") {
      // For Arabic locale, return only Arabic names
      return saudiLocations.keys
          .where((k) =>
              isArabic(k)) // Filters only the keys containing Arabic characters
          .toList();
    } else {
      // For non-Arabic locale, return only non-Arabic names
      return saudiLocations.keys
          .where((k) => !isArabic(
              k)) // Filters only the keys not containing Arabic characters
          .toList();
    }
  }

  List<String> regions = [];
  List<String> districts = [];

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
            DropdownButtonFormField<String>(
              value: selectedGovernorate,
              items: governorates.map((gov) {
                return DropdownMenuItem(value: gov, child: Text(gov));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGovernorate = value;
                  selectedRegion = null;
                  selectedDistrict = null;
                  regions =
                      saudiLocations[selectedGovernorate]?.keys.toList() ?? [];
                });
              },
              decoration: InputDecoration(labelText: "Governorate".tr),
            ),
            const SizedBox(height: 20),

            // Region Dropdown
            DropdownButtonFormField<String>(
              value: selectedRegion,
              items: regions.map((region) {
                return DropdownMenuItem(value: region, child: Text(region));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRegion = value;
                  selectedDistrict = null;
                  districts = (saudiLocations[selectedGovernorate]
                          ?[selectedRegion] as List<String>?) ??
                      [];
                });
              },
              decoration: InputDecoration(labelText: "Region".tr),
            ),
            const SizedBox(height: 20),

            // District Dropdown
            DropdownButtonFormField<String>(
              value: selectedDistrict,
              items: districts.map((district) {
                return DropdownMenuItem(value: district, child: Text(district));
              }).toList(),
              onChanged: (value) {
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

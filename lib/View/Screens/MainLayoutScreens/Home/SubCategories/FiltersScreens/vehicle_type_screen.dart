import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Utilities/icons.dart';
import '../../../../../Widgets/utilities_widgets/text_Component.dart';

class VehicleTypeScreen extends StatefulWidget {
  const VehicleTypeScreen({super.key});

  @override
  State<VehicleTypeScreen> createState() => _VehicleTypeScreenState();
}

class _VehicleTypeScreenState extends State<VehicleTypeScreen> {
  List<String> typeOfVehicle = [
    "Buses for rent",
    "Cars",
    "Equipment for rent",
    "Boat rental",
    "Bicycle rental",
    "taxi",
  ];

  List<bool> selectedGasTypes =
  List<bool>.filled(7, false); // List to track selected gas types.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: "vehicleType".tr, // Change the key to match the translation
          color: Colors.black,
          size: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Get.locale?.languageCode == 'en'
              ? IconBroken.Arrow___Left_2
              : IconBroken.Arrow___Right_2),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedGasTypes = List<bool>.filled(
                    selectedGasTypes.length, false); // Reset selection
              });
            },
            child: TextComponent(
              text: "Reset".tr,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              size: 16,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10), // Add some spacing
          Expanded(
            child: ListView.builder(
              itemCount: typeOfVehicle.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.grey, width: 0.4),
                    ),
                    child: CheckboxListTile(
                      value: selectedGasTypes[index],
                      onChanged: (value) {
                        setState(() {
                          selectedGasTypes[index] = value!;
                        });
                      },
                      title: TextComponent(
                        text: typeOfVehicle[index].tr,
                        size: 16,
                        fontWeight: FontWeight.bold, color: Colors.black87,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Handle show results action
                },
                child: Text(
                  "إظهار النتائج", // Adjust translation key here if necessary
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

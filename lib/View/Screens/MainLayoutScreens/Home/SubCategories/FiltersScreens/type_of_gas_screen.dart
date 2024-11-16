import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Utilities/icons.dart';
import '../../../../../Widgets/utilities_widgets/text_Component.dart';

class TypeOfGasScreen extends StatefulWidget {
  const TypeOfGasScreen({super.key});

  @override
  State<TypeOfGasScreen> createState() => _TypeOfGasScreenState();
}

class _TypeOfGasScreenState extends State<TypeOfGasScreen> {
  List<String> typeOfGas = [
    "gasoline",
    "diesel",
    "mixed",
    "electrical",
    "Flexible fuel",
    "Hydrogen fuel cell",
    "natural gas",
  ];

  List<bool> selectedGasTypes =
      List<bool>.filled(7, false); // List to track selected gas types.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: "FuelType".tr, // Change the key to match the translation
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
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "for example: gasoline".tr,
                // Adjust translation
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: typeOfGas.length,
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
                        text: typeOfGas[index].tr,
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
                 Navigator.pop(context, typeOfGas[0]);
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

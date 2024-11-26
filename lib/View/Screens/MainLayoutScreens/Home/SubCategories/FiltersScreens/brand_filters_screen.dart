import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';
import '../../../../../../Utilities/icons.dart';

class BrandFiltersScreen extends StatefulWidget {
  const BrandFiltersScreen({super.key});

  @override
  State<BrandFiltersScreen> createState() => _BrandFiltersScreenState();
}

class _BrandFiltersScreenState extends State<BrandFiltersScreen> {
  // List of car brands with Arabic and English names
  final List<Map<String, String>> brands = [
    {"arName": "أودي جديد", "ename": "Audi"},
    {"arName": "بي ام دبليو جديد", "ename": "BMW"},
    {"arName": "كاديلاك جديد", "ename": "Cadillac"},
    {"arName": "شيفرولية جديد", "ename": "Chevrolet"},
    {"arName": "كرايسلر جديد", "ename": "Chrysler"},
    {"arName": "فورد جديد", "ename": "Ford"},
    {"arName": "جي إم سي جديد", "ename": "GMC"},
    {"arName": "هوندا جديد", "ename": "Honda"},
    {"arName": "هيونداي جديد", "ename": "Hyundai"},
    {"arName": "جاجوار جديد", "ename": "Jaguar"},
    {"arName": "كيا جديد", "ename": "Kia"},
    {"arName": "لاند روفر جديد", "ename": "Land Rover"},
    {"arName": "لكزس جديد", "ename": "Lexus"},
    {"arName": "لينكون جديد", "ename": "Lincoln"},
    {"arName": "مرسيدس جديد", "ename": "Mercedes"},
    {"arName": "ميتسوبيشي جديد", "ename": "Mitsubishi"},
    {"arName": "نيسان جديد", "ename": "Nissan"},
    {"arName": "بورش جديد", "ename": "Porsche"},
  ];

  // Track selected brands
  late List<bool> selectedBrands;

  @override
  void initState() {
    super.initState();
    selectedBrands =
        List<bool>.filled(brands.length, false); // Initially no brand selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: "Brand".tr,
          color: Colors.black,
          size: 18,
          fontWeight: FontWeight.bold,
        ),
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
                selectedBrands = List<bool>.filled(brands.length, false);
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
                hintText: "for example: Audi".tr,
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
              itemCount: brands.length,
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
                      value: selectedBrands[index],
                      onChanged: (value) {
                        setState(() {
                          selectedBrands[index] = value!;
                        });
                      },
                      title: Text(
                        brands[index]["ename"]!,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.right,
                      ),
                      subtitle: Text(
                        brands[index]["arName"]!,
                        style: TextStyle(color: Colors.black54),
                        textAlign: TextAlign.right,
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
                  if (selectedBrands.contains(true)) {
                    Navigator.pop(context, selectedBrands);
                  }
                },
                child: Text(
                  "done".tr,
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

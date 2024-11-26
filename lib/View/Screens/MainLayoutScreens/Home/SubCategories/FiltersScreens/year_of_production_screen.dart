import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';
import '../../../../../../Utilities/icons.dart';

class YearOfProductionScreen extends StatefulWidget {
  final bool allowMultipleSelection;

  const YearOfProductionScreen({super.key, required this.allowMultipleSelection});

  @override
  State<YearOfProductionScreen> createState() => _YearOfProductionScreenState();
}

class _YearOfProductionScreenState extends State<YearOfProductionScreen> {
  late List<String> years;
  late List<bool> selectedYears;

  @override
  void initState() {
    super.initState();
    generateYearsList();
  }

  void generateYearsList() {
    int currentYear = DateTime.now().year;
    years = List<String>.generate(45, (index) => (currentYear - index).toString());
    years.add("Before ${years.last}"); // Add the "Before {last year}" option at the end
    selectedYears = List<bool>.filled(years.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
          text: "YearOfProduction".tr,
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
        actions: widget.allowMultipleSelection
            ? [
          TextButton(
            onPressed: () {
              setState(() {
                selectedYears = List<bool>.filled(selectedYears.length, false);
              });
            },
            child: TextComponent(
              text: "Reset".tr,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
              size: 16,
            ),
          ),
        ]
            : null,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "for example: 2020".tr,
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
              itemCount: years.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.grey, width: 0.4),
                    ),
                    child: CheckboxListTile(
                      value: selectedYears[index],
                      onChanged: (value) {
                        if (widget.allowMultipleSelection) {
                          setState(() {
                            selectedYears[index] = value!;
                          });
                        } else {
                          // For single selection, reset all other selections
                          setState(() {
                            for (int i = 0; i < selectedYears.length; i++) {
                              selectedYears[i] = false;
                            }
                            selectedYears[index] = value!;
                          });
                        }
                      },
                      title: Text(
                        years[index],
                        style: TextStyle(fontSize: 16),
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
                  // Get the selected years
                  List<String> selectedYearsList = [];
                  for (int i = 0; i < selectedYears.length; i++) {
                    if (selectedYears[i]) {
                      selectedYearsList.add(years[i]);
                    }
                  }

                  // Return based on selection mode
                  if (widget.allowMultipleSelection) {
                    Navigator.pop(context, selectedYearsList);
                  } else {
                    String? singleYear = selectedYearsList.isNotEmpty ? selectedYearsList.first : null;
                    Navigator.pop(context, singleYear);
                  }
                },
                child: Text(
                  widget.allowMultipleSelection ? "Show Results".tr : "Select Year".tr,
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

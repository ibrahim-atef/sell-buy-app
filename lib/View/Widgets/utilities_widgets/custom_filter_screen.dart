import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFilterScreen extends StatefulWidget {
  final String title;
  final List<String> options;
  final bool allowMultipleSelection;

  const CustomFilterScreen({
    super.key,
    required this.title,
    required this.options,
    this.allowMultipleSelection = false,
  });

  @override
  State<CustomFilterScreen> createState() => _CustomFilterScreenState();
}

class _CustomFilterScreenState extends State<CustomFilterScreen> {
  late List<bool> selectedOptions;
  bool _isNavigating = false; // Prevent multiple pop calls

  @override
  void initState() {
    super.initState();
    selectedOptions = List<bool>.filled(widget.options.length, false);
  }

  void handleSelection(int index) {
    setState(() {
      if (widget.allowMultipleSelection) {
        selectedOptions[index] = !selectedOptions[index];
      } else {
        for (int i = 0; i < selectedOptions.length; i++) {
          selectedOptions[i] = i == index;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            if (!_isNavigating) {
              _isNavigating = true;
              Get.back();
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedOptions =
                List<bool>.filled(widget.options.length, false);
              });
            },
            child: const Text(
              "Reset",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
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
                hintText: "for example: ".tr + widget.options[0].tr,
                prefixIcon: const Icon(Icons.search),
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
              itemCount: widget.options.length,
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
                      value: selectedOptions[index],
                      onChanged: (_) => handleSelection(index),
                      title: Text(
                        widget.options[index].tr,
                        style: const TextStyle(fontSize: 16),
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
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                Future.delayed(Duration.zero , () {
                  if (_isNavigating) return;
                  _isNavigating = true;

                  final selectedItems = widget.options
                      .asMap()
                      .entries
                      .where((entry) => selectedOptions[entry.key])
                      .map((entry) => entry.value)
                      .toList();

                  Get.back(result: widget.allowMultipleSelection ? selectedItems : selectedItems.first);
                });
                },
                child: Text(
                  widget.allowMultipleSelection ? "viewResults".tr : "done".tr,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

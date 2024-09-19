import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../../../../../Utilities/categories.dart';

class HomeGridViewComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 7,
          crossAxisSpacing: 7,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return GestureDetector(
            onTap: () {
              debugPrint('Category tapped:-${category.name.tr}');
              // Define the action when category is tapped (e.g., navigate to subcategories)
              Get.snackbar(
                  "Selected Category", category.name.tr); // For demonstration
            },
            child: Card(
              elevation: .6,
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Category Image
                  Expanded(
                    child: category.imagePath != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                category.imagePath!,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  // Fallback widget when image loading fails
                                  return Icon(Icons.image_not_supported);
                                },
                              ),
                            ),
                          )
                        : Icon(Icons
                            .image_not_supported), // Fallback if imagePath is null
                  ),

                  // Category Name
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: TextComponent(
                        text: category.name.tr,
                        size: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

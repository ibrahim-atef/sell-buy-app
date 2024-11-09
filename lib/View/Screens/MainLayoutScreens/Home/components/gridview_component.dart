import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/create_ad_controller.dart';
import 'package:sell_buy/Controllers/home_controller.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_loader_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_shimmer_widget.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../SubCategories/sub_categories_screen.dart';

class HomeGridViewComponent extends StatelessWidget {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width,
        child: GetBuilder<HomeController>(
          builder: (_) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 7,
                crossAxisSpacing: 7,
              ),
              itemCount: homeController.categoriesList.length,
              itemBuilder: (context, index) {
                // Check if we're showing categories or subcategories

                // Display category item
                final category = homeController.categoriesList[index];

                return GestureDetector(
                  onTap: () {
                    debugPrint('Category tapped: ${category.name.tr}');
                    homeController.setSearchQuery(category);
                    Get.to(() => SubCategoriesScreen(
                          categoryId: category.id,
                        ));
                  },
                  child: Card(
                    elevation: .6,
                    margin: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Category Image with shimmer loading
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                category.imagePath,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child; // Image is fully loaded
                                  }
                                  // Show circular progress indicator until the image loads
                                  return Center(
                                    child: LoaderComponent(
                                      color: Colors.black54,
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  // Fallback widget when image loading fails
                                  return Icon(Icons.image_not_supported);
                                },
                              ),
                            ),
                          ),
                        ),

                        // Category Name
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          child: TextComponent(
                            text: Get.locale!.languageCode == "ar"
                                ? category.arName
                                : category.name,
                            size: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

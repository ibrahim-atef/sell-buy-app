import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_shimmer_widget.dart';
import '../../../../../Controllers/create_ad_controller.dart';
import '../../../../../Model/categories_subcategories_model.dart';
import '../../../../../Utilities/themes.dart';

class CategorySelectionScreen extends StatelessWidget {
  final controller = Get.put(CreateAdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
      ),
      body: GetBuilder<CreateAdController>(
        builder: (_) => controller.isLoadingCategories.value
            ? ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) => CustomShimmer(
                  child: Container(
                    margin: EdgeInsets.all(4),
                    height: Get.height * 0.07,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5EA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  baseColor: baseColorShimmer,
                  highlightColor: highlightColorShimmer,
                ),
              )
            : ListView.builder(
                itemCount: controller.categoriesList.length,
                itemBuilder: (context, index) {
                  final category = controller.categoriesList[index];
                  return CategoryExpansionTile(
                    category: category,
                    isExpanded: controller.isCategoryExpanded(category.id),
                    onExpansionChanged: (isExpanded) {
                      controller.toggleCategoryExpansion(category.id);
                    },
                  );
                },
              ),
      ),
    );
  }
}

class CategoryExpansionTile extends StatelessWidget {
  final Category category;
  final bool isExpanded;
  final Function(bool) onExpansionChanged;

  CategoryExpansionTile({
    required this.category,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  final controller = Get.find<CreateAdController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ExpansionPanelList(
        elevation: 1,
        expansionCallback: (int index, bool isExpanded) {
          onExpansionChanged(!isExpanded);
        },
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                leading: Image.network(
                  category.imagePath!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported, size: 40),
                ),
                title: Text(Get.locale!.languageCode == "ar"
                    ? category.arName
                    : category.name),
              );
            },
            body: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: category.subcategories?.length ?? 0,
              itemBuilder: (context, index) {
                final subcategory = category.subcategories![index];
                return SubcategoryExpansionTile(
                  subcategory: subcategory,
                  isExpanded: controller.isSubcategoryExpanded(subcategory.id),
                  categoryId: category.id,
                  onExpansionChanged: (isExpanded) {
                    controller.toggleSubcategoryExpansion(subcategory.id);
                  },
                );
              },
            ),
            isExpanded: isExpanded,
            canTapOnHeader: true,
          ),
        ],
      ),
    );
  }
}

// Subcategory Tile to show second-level subcategories with optional third-level subcategories
class SubcategoryExpansionTile extends StatelessWidget {
  final Subcategory subcategory;
  final String categoryId;
  final bool isExpanded;
  final Function(bool) onExpansionChanged;

  SubcategoryExpansionTile({
    required this.subcategory,
    required this.categoryId,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  final controller = Get.find<CreateAdController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: (subcategory.subcategories == null ||
              subcategory.subcategories!.isEmpty)
          ? GestureDetector(
              onTap: () {
                // Directly set the selected category and subcategory if no further options exist
                controller.setSelectedCategoryAndSubcategory(
                  categoryId,
                  subcategory.id,
                  "",
                );
              },
              child: ListTile(
                title: Text(Get.locale!.languageCode == "ar"
                    ? subcategory.arName
                    : subcategory.name),
              ),
            )
          : ExpansionPanelList(
              elevation: 1,
              expansionCallback: (int index, bool isExpanded) {
                onExpansionChanged(!isExpanded);
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text(Get.locale!.languageCode == "ar"
                          ? subcategory.arName
                          : subcategory.name),
                    );
                  },
                  body: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: subcategory.subcategories!.length,
                    itemBuilder: (context, index) {
                      final lastLevelSubcategory =
                          subcategory.subcategories![index];
                      return ListTile(
                        title: Text(Get.locale!.languageCode == "ar"
                            ? lastLevelSubcategory.arName
                            : lastLevelSubcategory.name),
                        onTap: () {
                          // Handle selection of last-level subcategory
                          controller.setSelectedCategoryAndSubcategory(
                            categoryId,
                            subcategory.id,
                            lastLevelSubcategory.id,
                          );
                        },
                      );
                    },
                  ),
                  isExpanded: isExpanded,
                  canTapOnHeader: true,
                ),
              ],
            ),
    );
  }
}

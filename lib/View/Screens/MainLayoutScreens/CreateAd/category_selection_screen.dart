import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Controllers/create_ad_controller.dart';
import '../../../../Model/categories_model.dart';
import '../../../../Utilities/categories.dart';

class CategorySelectionScreen extends StatelessWidget {
  final controller = Get.put(CreateAdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
      ),
      body: GetBuilder<CreateAdController>(
        builder: (_) => ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryExpansionTile(
              category: category,
              isExpanded: controller.isCategoryExpanded(category.id),
              onExpansionChanged: (isExpanded) {
                controller.toggleCategoryExpansion(index);
              },

            );
          },
        ),
      ),
    );
  }
}

// Widget for a single expandable category item
class CategoryExpansionTile extends StatelessWidget {
  final Category category;
  final bool isExpanded;
  final Function(bool) onExpansionChanged;


  CategoryExpansionTile({
    required this.category,
    required this.isExpanded,
    required this.onExpansionChanged,

  });
  final controller = Get.put(CreateAdController());

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
                leading: Image.asset(
                  category.imagePath!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported, size: 40),
                ),
                title: Text(category.name.tr),
              );
            },
            body: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: category.subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = category.subcategories[index];
                return ListTile(
                  style: ListTileStyle.drawer,
                  title: Text(subcategory.name.tr),
                  onTap: () => controller.setSelectedCategoryAndSubcategory(category.id, subcategory.id),
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

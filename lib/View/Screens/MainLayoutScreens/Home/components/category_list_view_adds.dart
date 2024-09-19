import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Model/ad_model.dart';
import 'add_card.dart';

class CategoryListView extends StatelessWidget {
  final String categoryName;
  final List<ItemModel> items; // A list of items to display in this category

  const CategoryListView({
    Key? key,
    required this.categoryName,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Text(
            categoryName.tr, // Localized category name
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200, // You can adjust this height according to your design
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ItemCard(item: item);
            },
          ),
        ),
      ],
    );
  }
}

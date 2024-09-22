import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/themes.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/divider_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../../Model/ad_model.dart';
import 'add_card.dart';

class CategoryListView extends StatelessWidget {
  final String categoryName;
  final String categoryArName;
  final List<AdModel> items; // A list of items to display in this category

  const CategoryListView({
    Key? key,
    required this.categoryName,
    required this.categoryArName,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: TextComponent(
              text: Get.locale!.languageCode == 'ar'
                  ? categoryArName
                  : categoryName,
              size: 18,
              color: black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 200, // You can adjust this height according to your design
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return AdCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/themes.dart';

import '../../../../../Controllers/home_controller.dart';
import '../../../../../Model/ad_model.dart';
import '../../../../Widgets/utilities_widgets/text_Component.dart';
import '../ad_details screen.dart';

class AdCard extends StatelessWidget {
  final AdModel item;
  final homeController = Get.put(HomeController());

  AdCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => AdDetailsScreen(ad: item, adId: item.id));
        },
        child: Container(
        width: 160, // Adjust width as needed
        child: Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Item image
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    item.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported);
                    },
                  ),
                ),
              ),
              // Item details
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      text: item.title,
                      size: 14,
                      color: Colors.black,maxLines:1,
                      fontWeight: FontWeight.bold,
                    ),
                    TextComponent(
                      text: item.description,
                      size: 12,maxLines: 2,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,

                    ),
                    SizedBox(height: 4),
                    TextComponent(
                      text: item.price,
                      size: 14,
                      color: mainColor.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 4),
                    TextComponent(
                      text: homeController.timePassed(
                          item.createdAt
                              .toDate()
                              .millisecondsSinceEpoch),
                      size: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),);
  }
}

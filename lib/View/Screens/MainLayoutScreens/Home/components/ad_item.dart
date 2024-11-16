import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../../Controllers/ad_services_controller.dart';
import '../../../../../Model/ad_model.dart';
import '../../../../../Utilities/themes.dart';

import '../ad_details screen.dart';

class AdItem extends StatelessWidget {
  final AdModel item;
  final adServicesController = Get.put(AdServicesController());

  AdItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.18, // Adjust the height as needed
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            Get.to(() => AdDetailsScreen(ad: item, adId: item.id));
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Image Section
                ClipRRect(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                  child: Image.network(
                    item.imagePath,
                    fit: BoxFit.cover,
                    width: Get.width * 0.3,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: Get.width * 0.3,
                        color: Colors.grey[300],
                        child: Icon(Icons.image_not_supported, size: 40),
                      );
                    },
                  ),
                ),
                // Details Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                          text: item.title,
                          size: 16,
                          color: Colors.black,
                          maxLines: 1,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 4),
                        TextComponent(
                          text: item.description,
                          size: 12,
                          color: Colors.grey,
                          maxLines: 2,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(height: 8),
                        TextComponent(
                          text: item.price,
                          size: 14,
                          color: mainColor.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 4),
                        TextComponent(
                          text: adServicesController.timePassed(
                              item.createdAt.toDate().millisecondsSinceEpoch),
                          size: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

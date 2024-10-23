import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/themes.dart';
import '../../../../Controllers/ad_services_controller.dart';
import '../../../../Utilities/icons.dart';
import '../../../Widgets/utilities_widgets/custom_shimmer_widget.dart';
import '../../../Widgets/utilities_widgets/text_Component.dart';
import '../../../../../Model/ad_model.dart';
import '../Home/ad_details screen.dart'; // Import if you use AdModel for the recently viewed ads

class FavouriteAdsScreen extends StatelessWidget {
  final adServicesController = Get.put(AdServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextComponent(
            text: 'My Favorites'.tr,
            size: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold),
        leading: IconButton(
            icon: Icon(IconBroken.Arrow___Right_2),
            onPressed: () => Get.back()),
        elevation: 1,
      ),
      body: GetBuilder<AdServicesController>(builder: (_) {
        if (adServicesController.favouriteAds.isEmpty) {
          return Center(child: Text('No Ads Found'.tr));
        }
        return adServicesController.isGettingFavouritesAds.value
            ? ListView.builder(
                itemBuilder: (_, index) => Container(
                  height: Get.height * .2,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  width: Get.width,
                  color: highlightColorShimmer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomShimmer(
                        child: Container(
                          height: Get.height * .2,
                          width: Get.width * .3,
                          decoration: BoxDecoration(
                            color: baseColorShimmer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        baseColor: baseColorShimmer,
                        highlightColor: highlightColorShimmer,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          const SizedBox(height: 10),
                          CustomShimmer(
                            baseColor: baseColorShimmer,
                            highlightColor: highlightColorShimmer,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              height: Get.height * .02,
                              width: Get.width * .6,
                              color: baseColorShimmer,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomShimmer(
                            baseColor: baseColorShimmer,
                            highlightColor: highlightColorShimmer,
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              height: Get.height * .1,
                              width: Get.width * .6,
                              color: baseColorShimmer,
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                itemCount: 5,
              )
            : ListView.builder(
                itemCount: adServicesController.favouriteAds.length,
                itemBuilder: (_, index) {
                  AdModel ad = adServicesController.favouriteAds[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => AdDetailsScreen(ad: ad, adId: ad.id));
                      },
                      child: Container(
                        width: 160, // Adjust width as needed
                        child: Card(
                          elevation: 2,
                          child: Row(
                            children: [
                              SizedBox(
                                width: Get.width * .35,
                                height: Get.width * .35,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(8)),
                                  child: Image.network(
                                    ad.imagePath,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.image_not_supported);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * .60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Item details
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextComponent(
                                            text: ad.title,
                                            size: 14,
                                            color: Colors.black,
                                            maxLines: 1,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          TextComponent(
                                            text: ad.description,
                                            size: 12,
                                            maxLines: 4,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          SizedBox(height: 4),
                                          TextComponent(
                                            text: ad.price,
                                            size: 14,
                                            overflow: TextOverflow.ellipsis,
                                            color: mainColor.withOpacity(0.7),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(height: 4),
                                          TextComponent(
                                            text: adServicesController
                                                .timePassed(ad.createdAt
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }
}

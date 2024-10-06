import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/Utilities/themes.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Commercial/page_view_commercial_ads_screen.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';
import '../../../../Controllers/home_controller.dart';
import '../../../../Model/commercial_ad_model.dart';
import '../../../Widgets/utilities_widgets/custom_loader_component.dart';
import 'components/shimmer_commercial_ad_screen.dart';

class CommercialScreen extends StatelessWidget {
  CommercialScreen({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        final List<CommercialAdModel> filteredCommercialAds =
            homeController.getFilteredCommercialAds();

        return Scaffold(
          body: homeController.isLoadingCategories.value
              ? ShimmerCommercialAdScreen()
              : Column(
                  children: [
                    // Category List (Horizontal ListView)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.categoriesList.length,
                          itemBuilder: (context, index) {
                            final category =
                                homeController.categoriesList[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Obx(() => ChoiceChip(
                                    label: TextComponent(
                                        text: Get.locale!.languageCode == "ar"
                                            ? category.arName
                                            : category.name,
                                        color: Colors.black,
                                        size: 13,
                                        fontWeight: FontWeight.bold),
                                    backgroundColor: highlightColorShimmer,
                                    selectedColor: Colors.blue[200],
                                    selected: homeController
                                            .selectedCategoryId.value ==
                                        category.id,
                                    onSelected: (bool selected) {
                                      // Update the selected category
                                      if (selected) {
                                        homeController.selectedCategoryId
                                            .value = category.id;
                                      } else {
                                        homeController
                                            .selectedCategoryId.value = '';
                                      }
                                      homeController.update();
                                    },
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                    // Ads Grid
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: filteredCommercialAds.length,
                          itemBuilder: (context, index) {
                            return _buildAdCard(filteredCommercialAds[index],
                                function: () {Get.to(PgeViewCommercialAds(commercialAds: filteredCommercialAds,));});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  // Helper method to build AdCard
  Widget _buildAdCard(CommercialAdModel ad, {Function()? function}) {
    return GestureDetector(
      onTap: function,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ad Image
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    ad.imagePath ?? '',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image is fully loaded
                      }
                      // Show circular progress indicator until the image loads
                      return Center(
                        child: LoaderComponent(color: Colors.black54),
                      );
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      // Fallback widget when image loading fails
                      return Icon(Icons.image_not_supported);
                    },
                  ),
                ),
              ),
            ),

            // Action Buttons (WhatsApp & Call)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Image.asset("assets/Icons/whatsapp.png",
                        width: 25, height: 25),
                    onPressed: () {
                      // WhatsApp action
                    },
                  ),
                  IconButton(
                    icon: Icon(IconBroken.Call, color: Colors.blue),
                    onPressed: () {
                      // Call action
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

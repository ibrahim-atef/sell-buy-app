import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/home_controller.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/free_ad_space.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';
import '../../../../Controllers/ad_services_controller.dart';
import '../../../../Utilities/themes.dart';
import '../../../Widgets/utilities_widgets/Home_loading_shimmer.dart';
import 'components/gridview_component.dart';
import 'components/category_list_view_adds.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());
  final adServicesController = Get.put(AdServicesController());

  @override
  void initState() {
    adServicesController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (_) {
          bool allAdsEmpty =
              homeController.adsPerCategory.every((ads) => ads.isEmpty);

          return homeController.isLoadingCategories.value
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomeLoadingShimmer(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    // Call the refresh logic here, e.g., reloading categories and ads
                    await homeController.getCategoriesAndAds();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: HomeGridViewComponent(),
                        ),

                        // ListView for Categories and Ads
                        allAdsEmpty
                            ? Center(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Get.height * 0.1,
                                    ),
                                    child: FreeAdSpace(
                                      width: Get.width,
                                      height: Get.height * 0.19,
                                    )),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: homeController.adsPerCategory.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final category =
                                      homeController.categoriesList[index];
                                  final ads =
                                      homeController.adsPerCategory[index];

                                  // If ads for the category are empty, don't show anything
                                  return ads.isEmpty
                                      ? const SizedBox.shrink()
                                      : CategoryListView(
                                          categoryName: category
                                              .name, // Pass category name
                                          items:
                                              ads, // Pass list of ads for this category
                                          categoryArName: category.arName,
                                        );
                                },
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

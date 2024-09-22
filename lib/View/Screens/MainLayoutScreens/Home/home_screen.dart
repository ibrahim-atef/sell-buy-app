import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/home_controller.dart';
import '../../../Widgets/utilities_widgets/Home_loading_shimmer.dart';
import 'components/gridview_component.dart';
import 'components/category_list_view_adds.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (_) {
          return homeController.isLoadingCategories.value
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomeLoadingShimmer(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HomeGridViewComponent(),
                      ),
                      // ListView for Categories and Ads
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: homeController.categoriesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final category = homeController.categoriesList[index];
                          final ads = homeController.adsPerCategory[index];

                          return ads.isEmpty
                              ? const SizedBox.shrink()
                              : CategoryListView(
                                  categoryName:
                                      category.name, // Pass category name
                                  items:
                                      ads, categoryArName: category.arName, // Pass list of ads for this category
                                );
                        },
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/home_controller.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Home/components/ad_item.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/free_ad_space.dart';

import '../../../../../Controllers/subcategories_controller.dart';
import '../../../../../Utilities/icons.dart';
import '../../../../Widgets/SearchBar/search_bar_widget.dart';
import '../../../../Widgets/utilities_widgets/Home_loading_shimmer.dart';
import '../components/add_card.dart';
import '../components/subcategories_gridview.dart';

class SubCategoriesScreen extends StatefulWidget {
  final String categoryId;

  SubCategoriesScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  final homeController = Get.put(HomeController());

  final subCategoriesController = Get.put(SubCategoriesController());

  @override
  void initState() {
    subCategoriesController.getSubCategories(widget.categoryId);
    subCategoriesController.getAdsForCategory(widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return GetBuilder<SubCategoriesController>(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              elevation: .5,
              title: SearchBarWidget(),
              leading: homeController.searchText.value != ""
                  ? IconButton(
                      onPressed: () {
                        Get.back();
                        homeController.clearSearchQuery();
                      },
                      icon: Icon(Get.locale?.languageCode == 'en'
                          ? IconBroken.Arrow___Left_2
                          : IconBroken.Arrow___Right_2),
                    )
                  : null,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        subCategoriesController.isLoadingSubCategories.value &&
                                subCategoriesController.isLoadingAds.value
                            ? HomeLoadingShimmer()
                            : GridviewSubcategories(
                                subcategoryList:
                                    subCategoriesController.subcategoryList,
                              ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  subCategoriesController.AdsPerCategory.isEmpty
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
                          itemCount:
                              subCategoriesController.AdsPerCategory.length,
                          itemBuilder: (context, index) {
                            final item =
                                subCategoriesController.AdsPerCategory[index];
                            return AdItem(item: item);
                          },
                        )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

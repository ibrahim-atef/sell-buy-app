import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Model/ad_model.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../../Controllers/ad_services_controller.dart';
import '../../../../../Controllers/home_controller.dart';
import '../../../../../Controllers/subcategories_controller.dart';
import '../../../../../Utilities/icons.dart';
import '../../../../../Utilities/themes.dart';
import '../../../../Widgets/SearchBar/search_bar_widget.dart';
import '../../../../Widgets/utilities_widgets/free_ad_space.dart';
import '../../../../Widgets/utilities_widgets/list_loading_shimmer.dart';
import '../components/ad_item.dart';

class AdsScreenPerLastSubCategory extends StatefulWidget {
  final String categoryId;
  final String subcategoryId;
  final String lastSubcategoryId;

  AdsScreenPerLastSubCategory({
    Key? key,
    required this.categoryId,
    required this.subcategoryId,
    required this.lastSubcategoryId,
  });

  @override
  State<AdsScreenPerLastSubCategory> createState() =>
      _AdsScreenPerLastSubCategoryState();
}

class _AdsScreenPerLastSubCategoryState
    extends State<AdsScreenPerLastSubCategory> {
  final subCategoriesController = Get.put(SubCategoriesController());
  final homeController = Get.put(HomeController());

  String? _selectedSortOption = "most_matching";

  @override
  void initState() {
    subCategoriesController.getAllAdsForLastSubcategory(
        categoryId: widget.categoryId,
        subcategoryId: widget.subcategoryId,
        lastSubcategoryId: widget.lastSubcategoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoriesController>(
      builder: (_) {
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
          body: subCategoriesController.isLoadingAdsForLastSubcategory.value
              ? ListLoadingShimmer()
              : subCategoriesController.adsPerLastSubcategory == null
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
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextComponent(
                                  text:
                                      "${subCategoriesController.adsPerLastSubcategory.length == 0 ? "No".tr : subCategoriesController.adsPerLastSubcategory.length} " +
                                          "Ad".tr,
                                  size: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              GestureDetector(
                                onTap: _openSortOptions,
                                child: Row(
                                  children: [
                                    TextComponent(
                                        text: "Sort by".tr,
                                        size: 18,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.normal),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(IconBroken.Filter_2,
                                        color: Colors.blueAccent, size: 18),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        subCategoriesController.adsPerLastSubcategory.isEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.02,
                                ),
                                child: FreeAdSpace(
                                  width: Get.width,
                                  height: Get.height * 0.19,
                                ))
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    itemCount: subCategoriesController
                                        .adsPerLastSubcategory.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      AdModel item = subCategoriesController
                                          .adsPerLastSubcategory[index];
                                      return AdItem(
                                        item: item,
                                      );
                                    },
                                  ),
                                ),
                              )
                      ],
                    ),
        );
      },
    );
  }

  void _openSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile<String>(
                title: Text("Most Matching".tr),
                value: "most_matching",
                groupValue: _selectedSortOption,
                onChanged: (value) {
                  setState(() {
                    _selectedSortOption = value;
                  });
                  Navigator.pop(context); // Close the modal after selection
                },
              ),
              RadioListTile<String>(
                title: Text("Lowest Price".tr),
                value: "lowest_price",
                groupValue: _selectedSortOption,
                onChanged: (value) {
                  setState(() {
                    _selectedSortOption = value;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text("Highest Price".tr),
                value: "highest_price",
                groupValue: _selectedSortOption,
                onChanged: (value) {
                  setState(() {
                    _selectedSortOption = value;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text("Latest".tr),
                value: "latest",
                groupValue: _selectedSortOption,
                onChanged: (value) {
                  setState(() {
                    _selectedSortOption = value;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text("Oldest".tr),
                value: "oldest",
                groupValue: _selectedSortOption,
                onChanged: (value) {
                  setState(() {
                    _selectedSortOption = value;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

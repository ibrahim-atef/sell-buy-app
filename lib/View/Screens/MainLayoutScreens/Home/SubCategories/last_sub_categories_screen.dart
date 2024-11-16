import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/home_controller.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Home/components/commercial_ads_horizontal_for_sub.dart';
import 'package:sell_buy/View/Screens/MainLayoutScreens/Home/components/used_car_filters_bar_section.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/free_ad_space.dart';

import '../../../../../Controllers/subcategories_controller.dart';
import '../../../../../Utilities/icons.dart';
import '../../../../Widgets/SearchBar/search_bar_widget.dart';
import '../../../../Widgets/utilities_widgets/Home_loading_shimmer.dart';
import '../../../../Widgets/utilities_widgets/text_Component.dart';
import '../components/add_card.dart';
import '../components/electronics_filter_bar.dart';
import '../components/last_subcategories_gridview.dart';
import '../components/location_filters_bar.dart';
import '../components/rental_car_filter_section.dart';
import '../components/subcategories_gridview.dart';

class LastSubCategoriesScreen extends StatefulWidget {
  final String categoryId;
  final String subCategoryId;

  LastSubCategoriesScreen(
      {Key? key, required this.categoryId, required this.subCategoryId})
      : super(key: key);

  @override
  State<LastSubCategoriesScreen> createState() =>
      _LastSubCategoriesScreenState();
}

class _LastSubCategoriesScreenState extends State<LastSubCategoriesScreen> {
  final homeController = Get.put(HomeController());

  final subCategoriesController = Get.put(SubCategoriesController());

  @override
  void initState() {
    subCategoriesController.getLastSubCategories(
        categoryId: widget.categoryId, subcategoryId: widget.subCategoryId);
    subCategoriesController.getAdsForSubcategory(
        categoryId: widget.categoryId, subcategoryId: widget.subCategoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return GetBuilder<SubCategoriesController>(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
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
                  ///-----------------------------------------used cars filters bar section--------------------------------------------
                  widget.subCategoryId == "Used Cars"
                      ? SizedBox(
                          width: Get.width,
                          height: Get.height * 0.07,
                          child: UsedCarsFiltersBarSection())

                      ///-----------------------------------------Rentals cars filters bar section--------------------------------------------
                      : widget.subCategoryId == "Rentals"
                          ? SizedBox(
                              width: Get.width,
                              height: Get.height * 0.07,
                              child: RentalCarFiltersBarSection())

                          ///-----------------------------------------services cars filters bar section--------------------------------------------
                          : widget.categoryId == "services"
                              ? SizedBox(
                                  width: Get.width,
                                  height: Get.height * 0.07,
                                  child: LocationFiltersBar())

                              ///-----------------------------------------electronics-phones cars filters bar section--------------------------------------------
                              : widget.subCategoryId == "electronics-phones"
                                  ? SizedBox(
                                      width: Get.width,
                                      height: Get.height * 0.07,
                                      child: ElectronicsFilterBar())
                                  : SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent(
                            text:
                                "${(subCategoriesController.commercialAdsPerSubcategory.isEmpty && subCategoriesController.AdsPerSubcategory.isEmpty) ? "No".tr : subCategoriesController.AdsPerSubcategory.length + subCategoriesController.commercialAdsPerSubcategory.length} " +
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        subCategoriesController.isLoadingLastSubCategories.value
                            ? HomeLoadingShimmer()
                            : LastGridviewSubcategories(
                                lastSubcategoryList:
                                    subCategoriesController.lastSubcategoryList,
                              ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CommercialAdsHorizontalForSub(
                      subcategoryId: widget.subCategoryId,
                      categoryId: widget.categoryId),
                  SizedBox(
                    height: 10,
                  ),
                  subCategoriesController.AdsPerSubcategory.isEmpty
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
                      : SizedBox(
                          height: 200,
                          // You can adjust this height according to your design
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: subCategoriesController
                                .AdsPerSubcategory.length,
                            itemBuilder: (context, index) {
                              final item = subCategoriesController
                                  .AdsPerSubcategory[index];
                              return AdCard(item: item);
                            },
                          ),
                        )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  String? _selectedSortOption = "most_matching";

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

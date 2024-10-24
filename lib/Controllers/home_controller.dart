import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_buy/Model/categories_subcategories_model.dart';
import 'package:sell_buy/Model/ad_model.dart'; // Assuming AdModel is in this file
import 'package:sell_buy/Model/commercial_ad_model.dart';
import 'package:sell_buy/Routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Services/firestore_methods.dart';
import '../Utilities/my_strings.dart';

class HomeController extends GetxController {
  final GetStorage storageBox = GetStorage();
  late String userId;
  List<AdModel> favouriteAds = [];
  RxBool isLoadingCommercialAds = false.obs; // Loading state for commercial ads

  @override
  void onInit() {
    super.onInit();

    userId = storageBox.read(KUid) ?? "";
    getCategoriesAndAds(); // Call function to fetch categories and ads

    searchListener();
  }

  RxString searchText = ''.obs;
  TextEditingController searchController = TextEditingController();
  List<Category> categoriesList = <Category>[]; // S
  List<Subcategory> subcategoriesForSelectedCategory =
      <Subcategory>[]; // tore categories

  List<List<AdModel>> adsPerCategory =
      <List<AdModel>>[]; // Store ads for each category
  List<List<CommercialAdModel>> commercialAdsPerCategory =
      <List<CommercialAdModel>>[];
  RxBool isLoadingCategories = false.obs;
  RxBool isLoadingAds = false.obs; // Separate loading state for ads
  RxString selectedCategoryId = ''.obs; // Track the selected category
  List<AdModel> filteredAdsPerCategory = <AdModel>[].obs;  // Observe this
  // Method to filter commercial ads by category ID
  List<CommercialAdModel> getFilteredCommercialAds() {
    if (selectedCategoryId.value.isEmpty) {
      // Return all ads if no category is selected
      return commercialAdsPerCategory.expand((ads) => ads).toList();
    } else {
      // Return only the ads of the selected category
      int index = categoriesList
          .indexWhere((category) => category.id == selectedCategoryId.value);
      if (index != -1) {
        return commercialAdsPerCategory[index];
      }
    }
    return [];
  }
  /// --------------------->>>>>>>>>>>>>>>>>>>>>>>>>>  search screen logic --------------------------------------
  RxList<AdModel> searchFilteredAds = <AdModel>[].obs;

  void searchFilterAds(String query) {
    if (query.isEmpty) {
      searchFilteredAds.clear();
      update();  // Notify UI to refresh
      return;
    }

    searchFilteredAds.value = adsPerCategory.expand((ads) => ads).where((ad) {
      final titleMatches = (ad.title?.toLowerCase() ?? '').contains(query.toLowerCase());
      final descriptionMatches = (ad.description?.toLowerCase() ?? '').contains(query.toLowerCase());

      // Add checks for category and subcategory
      final categoryMatches = selectedCategoryId.isNotEmpty &&
          (ad.category?.toLowerCase() == selectedCategoryId.value.toLowerCase());

      final subcategoryMatches = subcategoriesForSelectedCategory.isNotEmpty &&
          (ad.subCategory?.toLowerCase() == selectedSubcategoryId.value.toLowerCase());

      return titleMatches || descriptionMatches || categoryMatches || subcategoryMatches;
    }).toList();

    update(); // Notify UI of the changes
  }
  RxString selectedSubcategoryId = ''.obs;

  void setSelectedSubcategory(String subcategoryId) {
    selectedSubcategoryId.value = subcategoryId;
    searchFilterAds(searchController.text);
  }


  RxList<CommercialAdModel> filteredCommercialAds = <CommercialAdModel>[].obs;

  void searchFilterCommercialAds(String query) {
    if (query.isEmpty) {
      filteredCommercialAds.clear();
      update(); // Notify UI to refresh
      return;
    }

    // Flatten the nested list using expand
    filteredCommercialAds.value = commercialAdsPerCategory
        .expand((ads) => ads) // Flatten the list of lists
        .where((ad) {
      // Since CommercialAdModel doesn't have title or description fields,
      // you might want to filter based on other fields like category, subcategory, or owner name.
      final ownerNameMatches = (ad.ownerName.toLowerCase()).contains(query.toLowerCase());
      final categoryMatches = (ad.category.toLowerCase()).contains(query.toLowerCase());
      final subcategoryMatches = (ad.subCategory.toLowerCase()).contains(query.toLowerCase());
      final selectedSubcategoryMatches = (ad.selectedSubcategoryArName.toLowerCase()).contains(query.toLowerCase());

      // Add checks for category and subcategory if needed
      final categoryCheck = selectedCategoryId.isNotEmpty &&
          (ad.category.toLowerCase() == selectedCategoryId.value.toLowerCase());

      final subcategoryCheck = selectedSubcategoryId.isNotEmpty &&
          (ad.subCategory.toLowerCase() == selectedSubcategoryId.value.toLowerCase());

      return ownerNameMatches || categoryMatches || subcategoryMatches || selectedSubcategoryMatches || categoryCheck || subcategoryCheck;
    }).toList();

    update(); // Notify UI of the changes
  }



  void searchListener() {
    searchController.addListener(() {
      searchText.value = searchController.text;

      searchFilterAds(searchText.value); // Filter for regular ads
      searchFilterCommercialAds(searchText.value); // Filter for commercial ads

      if (searchController.text.isEmpty) {
        subcategoriesForSelectedCategory.clear(); // Clear subcategories when search is empty
        filterAds();
        filteredCommercialAds.clear(); // Clear commercial ads
        update(); // Notify UI to refresh
      }
    });
  }
  ///--------------------->>>>>>>>>>>>>>>>>>>>>>>>>>  search bar logic --------------------------------------
  void setSearchQuery(Category category) {
    searchController.text = Get.locale!.languageCode == 'ar' ? category.arName : category.name;

    // Set the selected category ID to filter ads for that category
    selectedCategoryId.value = category.id;

    // Clear or update subcategories list based on the selected category
    if (category.subcategories != null && category.subcategories!.isNotEmpty) {
      subcategoriesForSelectedCategory = List.from(category.subcategories!);
    } else {
      subcategoriesForSelectedCategory = <Subcategory>[];
    }
    filterAds();  // Trigger filtering logic


    // Trigger UI update
    update();
  }


  // Method to clear the search query
  void clearSearchQuery() {
    searchController.clear();
    selectedCategoryId.value = '';  // Clear category selection
    filteredAdsPerCategory.clear();  // Clear filtered list
    update();
  }

  void filterAds() {
    if (selectedCategoryId.isEmpty) {
      filteredAdsPerCategory.clear();
      update();  // Notify UI to refresh
      return;
    }

    // Get the index of the selected category
    int categoryIndex = categoriesList.indexWhere((category) => category.id == selectedCategoryId.value);

    if (categoryIndex == -1) {
      filteredAdsPerCategory.clear();
    } else {
      // Filter ads based on search text and selected category
      List<AdModel> categoryAds =List.from(adsPerCategory[categoryIndex]) ;


      // No search text, so show all ads for the selected category
      filteredAdsPerCategory = categoryAds;
      debugPrint("${filteredAdsPerCategory.length} ads filtered");

    }
    update();  // Notify UI of the changes
  }
  List<AdModel> randomAds = []; // Store random ads
  List<CommercialAdModel> randomCommercialAds = []; // Store random commercial ads

  // Method to fetch random ads
  void fetchRandomAds() {
    final random = Random();

    // Get a sample of random ads
    randomAds = adsPerCategory.expand((ads) => ads).toList();
    randomCommercialAds = commercialAdsPerCategory.expand((ads) => ads).toList();

    if (randomAds.isNotEmpty) {
      randomAds.shuffle(); // Shuffle to get random ads
      randomAds = randomAds.take(5).toList(); // Take 5 random ads
    }

    if (randomCommercialAds.isNotEmpty) {
      randomCommercialAds.shuffle();
      randomCommercialAds = randomCommercialAds.take(5).toList(); // Take 5 random commercial ads
    }

    update(); // Notify UI
  }
  /// Fetches categories and for each category retrieves its ads.
  Future<void> getCategoriesAndAds() async {
    debugPrint(
        "------- getting categories, subcategories, and their ads -------");
    isLoadingCategories.value = true;
    update();
    try {
      // Get the categories
      final categoriesSnapshot =
          await FireStoreMethods.categoriesCollection.get();

      categoriesList.clear(); // Clear previous categories
      adsPerCategory.clear(); // Clear previous ads lists
      commercialAdsPerCategory.clear(); // Clear previous commercial ads lists

      for (var categoryDoc in categoriesSnapshot.docs) {
        // Fetching and parsing categories
        try {
          Category category = Category.fromMap(categoryDoc.data());
          categoriesList.add(category);

          // Fetch the subcategories for this category
          final subcategoriesSnapshot = await FireStoreMethods
              .categoriesCollection
              .doc(category.id)
              .collection('subcategories')
              .get();

          List<Subcategory> subcategories = [];
          for (var subcategoryDoc in subcategoriesSnapshot.docs) {
            Subcategory subcategory =
                Subcategory.fromMap(subcategoryDoc.data());
            subcategories.add(subcategory);
          }

          // Add the subcategories to the category object
          category.subcategories = subcategories;

          // Fetch ads for this category
          List<AdModel> adsList = await getAdsForCategory(category.id);
          adsPerCategory.add(adsList); // Add ads to the corresponding category

          // Fetch commercial ads for this category
          List<CommercialAdModel> commercialAdsList =
              await getCommercialAdsForCategory(category.id);
          commercialAdsPerCategory.add(commercialAdsList); // Add commercial ads
          fetchRandomAds();
        } catch (e) {
          print('Error parsing category, subcategories, or fetching ads: $e');
        }
      }

      update(); // Update UI after fetching categories and ads
    } catch (error) {
      print("Error getting categories or ads: $error");
      Get.snackbar("Error", "Failed to load categories and ads: $error",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoadingCategories.value = false;
      isLoadingAds.value = false;
    }
  }

  /// Fetches ads for a given categoryId.
  Future<List<AdModel>> getAdsForCategory(String categoryId) async {
    isLoadingAds.value = true; // Start loading ads
    List<AdModel> adsList = [];

    try {
      // Assuming you have a collection for ads per category
      final adsSnapshot = await FirebaseFirestore.instance
          .collection(categoryId)
          .doc(usersAddsCollectionKey)
          .collection(
              usersAddsCollectionKey) // Adjust 'ads' if the sub-collection name is different
          .get();

      // Loop through ads in the snapshot
      for (var adDoc in adsSnapshot.docs) {
        try {
          AdModel ad = AdModel.fromJson(adDoc.data());
          adsList.add(ad); // Add ad to the list
        } catch (e) {
          print("Error parsing ad: $e");
        }
      }
    } catch (error) {
      print("Error fetching ads for category $categoryId: $error");
    } finally {
      isLoadingAds.value = false; // End loading ads
    }

    return adsList; // Return the list of ads for this category
  }

  /// Fetches commercial ads for a given categoryId.
  Future<List<CommercialAdModel>> getCommercialAdsForCategory(
      String categoryId) async {
    isLoadingCommercialAds.value = true; // Start loading commercial ads
    List<CommercialAdModel> commercialAdsList = [];

    try {
      final commercialAdsSnapshot = await FirebaseFirestore.instance
          .collection(categoryId)
          .doc(
              commercialsAddsCollectionKey) // Assuming there's a sub-collection for commercial ads
          .collection(commercialsAddsCollectionKey)
          .get();

      for (var commercialAdDoc in commercialAdsSnapshot.docs) {
        try {
          CommercialAdModel commercialAd =
              CommercialAdModel.fromJson(commercialAdDoc.data());
          commercialAdsList.add(commercialAd); // Add commercial ad to the list
        } catch (e) {
          print("Error parsing commercial ad: $e");
        }
      }
    } catch (error) {
      print("Error fetching commercial ads for category $categoryId: $error");
    } finally {
      isLoadingCommercialAds.value = false; // End loading commercial ads
    }

    return commercialAdsList; // Return the list of commercial ads for this category
  }

  ///--------------------->>>>>>>>>>>>>>>>>>>>>>>>>>  flutter lunching whatsapp by url --------------------------------------

  Future<void> openWhatsApp(String phoneNumber) async {
    String whatsappUrl = "whatsapp://send?phone=$phoneNumber";
    String dialUrl = "tel:$phoneNumber";

    // Check if WhatsApp is installed
    await launch(whatsappUrl);
  }

  ///--------------------->>>>>>>>>>>>>>>>>>>>>>>>>>  flutter lunching call by url --------------------------------------

  Future<void> openCall(String phoneNumber) async {
    String dialUrl = "tel:$phoneNumber";
    await launch(dialUrl);
  }




}

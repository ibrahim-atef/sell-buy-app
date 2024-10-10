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
    searchController.addListener(() {
      searchText.value = searchController.text;
      if (searchController.text.isEmpty) {
        subcategoriesForSelectedCategory
            .clear(); // Clear subcategories when search is empty
        update();
      }
    });
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

  ///--------------------->>>>>>>>>>>>>>>>>>>>>>>>>>  search bar logic --------------------------------------
  void setSearchQuery(Category category) {
    // Set the search query in the search controller (if needed)
    searchController.text =
        Get.locale!.languageCode == 'ar' ? category.arName : category.name;

    // Assign a **copy** of the subcategories to subcategoriesForSelectedCategory
    if (category.subcategories != null && category.subcategories!.isNotEmpty) {
      subcategoriesForSelectedCategory = List.from(category.subcategories!);
      debugPrint(
          "subcategoriesForSelectedCategory: $subcategoriesForSelectedCategory");
    } else {
      // If the category has no subcategories, clear the list
      subcategoriesForSelectedCategory = <Subcategory>[];
      debugPrint("No subcategories found for the selected category.");
    }

    // Ensure searchText is set so the UI reflects the correct state
    searchText.value = category.id;

    // Update the state to reflect changes
    update();
  }

  // Method to clear the search query
  void clearSearchQuery() {
    searchController.clear();

    // Clear the copied list, without affecting the original list in categories
    subcategoriesForSelectedCategory.clear();

    update();
  }
}

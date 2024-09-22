import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_buy/Model/categories_subcategories_model.dart';
import 'package:sell_buy/Model/ad_model.dart'; // Assuming AdModel is in this file
import '../Services/firestore_methods.dart';
import '../Utilities/my_strings.dart';

class HomeController extends GetxController {
  final GetStorage storageBox = GetStorage();
  late final String userId;

  @override
  void onInit() {
    super.onInit();
    userId = storageBox.read(KUid) ?? "";
    getCategoriesAndAds(); // Call function to fetch categories and ads
  }

  List<Category> categoriesList = <Category>[]; // Store categories
  List<List<AdModel>> adsPerCategory =
      <List<AdModel>>[]; // Store ads for each category
  RxBool isLoadingCategories = false.obs;
  RxBool isLoadingAds = false.obs; // Separate loading state for ads

  /// Fetches categories and for each category retrieves its ads.
  Future<void> getCategoriesAndAds() async {
    debugPrint("------- getting categories and their ads -------");
    isLoadingCategories.value = true;
    try {
      // Get the categories
      final categoriesSnapshot =
          await FireStoreMethods.categoriesCollection.get();
      categoriesList.clear(); // Clear previous categories
      adsPerCategory.clear(); // Clear previous ads lists

      for (var categoryDoc in categoriesSnapshot.docs) {
        // Fetching and parsing categories
        try {
          Category category = Category.fromMap(categoryDoc.data());
          categoriesList.add(category);

          // Now fetch ads for this category
          List<AdModel> adsList = await getAdsForCategory(category.id);
          adsPerCategory.add(adsList); // Add ads to the corresponding category
        } catch (e) {
          print('Error parsing category or fetching ads: $e');
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
          .collection(
              categoryId) // Adjust 'ads' if the sub-collection name is different
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

  /// Receive a time stamp and return how much time passed in minutes, hours or days
  String timePassed(int timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final diff = now - timestamp;

    final minutes = diff ~/ (1000 * 60);
    final hours = minutes ~/ 60;
    final days = hours ~/ 24;
    final months = days ~/ 30; // Approximation of a month (30 days)
    final years = days ~/ 365; // Approximation of a year (365 days)

    if (years > 0) {
      return '${years} ' + 'y'.tr; // Translate 'y' for year
    } else if (months > 0) {
      return '${months} ' + 'mo'.tr; // Translate 'mo' for months
    } else if (days > 0) {
      return '${days} ' + 'd'.tr; // Translate 'd' for days
    } else if (hours > 0) {
      return '${hours} ' + 'h'.tr; // Translate 'h' for hours
    } else {
      return '${minutes} ' + 'm'.tr; // Translate 'm' for minutes
    }
  }
}

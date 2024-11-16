import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Model/commercial_ad_model.dart';

import '../Model/ad_model.dart';
import '../Model/categories_subcategories_model.dart';
import '../Services/firestore_methods.dart';
import '../Utilities/my_strings.dart';

class SubCategoriesController extends GetxController {
  List<Subcategory> subcategoryList = <Subcategory>[];
  List<LastSubcategory> lastSubcategoryList = <LastSubcategory>[];
  List<AdModel> AdsPerCategory = [];
  List<AdModel> AdsPerSubcategory = [];
  RxBool isLoadingSubCategories = false.obs;
  RxBool isLoadingAds = false.obs;
  RxBool isLoadingLastSubCategories = false.obs;
  RxBool isLoadingAdsByLastSubcategory = false.obs;

  void getSubCategories(String categoryId) async {
    try {
      isLoadingSubCategories.value = true;
      subcategoryList.clear();
      final subcategoriesSnapshot = await FireStoreMethods.categoriesCollection
          .doc(categoryId)
          .collection('subcategories')
          .get();

      for (var subcategoryDoc in subcategoriesSnapshot.docs) {
        Subcategory subcategory = Subcategory.fromMap(subcategoryDoc.data());
        subcategoryList.add(subcategory);
      }
    } catch (e) {
      print('Error parsing subcategories: $e');
      Get.snackbar("Error", "Failed to load subcategories: $e",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoadingSubCategories.value = false;
      update();
    }
  }

  void getAdsForCategory(
    String categoryId,
  ) async {
    try {
      isLoadingAds.value = true;
      AdsPerCategory.clear();
      final adsSnapshot = await await FirebaseFirestore.instance
          .collection(categoryId)
          .doc(usersAddsCollectionKey)
          .collection(
              usersAddsCollectionKey) // Adjust 'ads' if the sub-collection name is different
          .get();

      for (var adDoc in adsSnapshot.docs) {
        AdModel ad = AdModel.fromJson(adDoc.data());
        AdsPerCategory.add(ad);
      } // Add ads to the corresponding subcategory object \
    } catch (e) {
      print('Error parsing ads: $e');
      Get.snackbar("Error", "Failed to load ads: $e",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoadingAds.value = false;
      update();
    }
  }

  getLastSubCategories(
      {required String categoryId, required String subcategoryId}) async {
    try {
      isLoadingLastSubCategories.value = true;
      lastSubcategoryList.clear();
      final lastSubcategoriesSnapshot = await FireStoreMethods
          .categoriesCollection
          .doc(categoryId)
          .collection('subcategories')
          .doc(subcategoryId)
          .collection('subcategories')
          .get();
      debugPrint(
          "------------------------------------------------------------lastSubcategoriesSnapshot: ${lastSubcategoriesSnapshot.docs.length}.");
      for (var subcategoryDoc in lastSubcategoriesSnapshot.docs) {
        LastSubcategory subcategory =
            LastSubcategory.fromMap(subcategoryDoc.data());
        debugPrint(subcategory.arName);
        lastSubcategoryList.add(subcategory);
      } // Add ads to the corresponding subcategory object \
    } catch (e) {
      print('Error parsing lastSubcategories: $e');
      Get.snackbar("Error", "Failed to load lastSubcategories: $e",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoadingLastSubCategories.value = false;
      update();
    }
  }

  void getAdsForSubcategory(
      {required String categoryId, required String subcategoryId}) async {
    try {
      isLoadingAdsByLastSubcategory.value = true;
      AdsPerSubcategory.clear();
      final adsSnapshot = await await FirebaseFirestore.instance
          .collection(categoryId)
          .doc(usersAddsCollectionKey)
          .collection(usersAddsCollectionKey)
          .where('subCategory',
              isEqualTo:
                  subcategoryId) // Adjust 'ads' if the sub-collection name is different
          .get();

      for (var adDoc in adsSnapshot.docs) {
        AdModel ad = AdModel.fromJson(adDoc.data());
        AdsPerSubcategory.add(ad);
      } // Add ads to the corresponding subcategory object \
    } catch (e) {
      print('Error parsing ads: $e');
      Get.snackbar("Error", "Failed to load ads: $e",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoadingAdsByLastSubcategory.value = false;
      update();
    }
  }

  /// fun to get ads for last subcategory
  List<AdModel> adsPerLastSubcategory = [];

  RxBool isLoadingAdsForLastSubcategory = false.obs;

  void getAllAdsForLastSubcategory(
      {required String categoryId,
      required String subcategoryId,
      required String lastSubcategoryId}) async {
    try {
      isLoadingAdsForLastSubcategory.value = true;
      adsPerLastSubcategory.clear();
      final adsSnapshot = await await FirebaseFirestore.instance
          .collection(categoryId)
          .doc(usersAddsCollectionKey)
          .collection(usersAddsCollectionKey)
          .where('thirdSubCategory', isEqualTo: lastSubcategoryId)
          .get();

      for (var adDoc in adsSnapshot.docs) {
        AdModel ad = AdModel.fromJson(adDoc.data());

        adsPerLastSubcategory.add(ad);
      } // Add ads to the corresponding subcategory object \
    } catch (e) {
      print('Error parsing ads: $e');
      Get.snackbar("Error", "Failed to load ads: $e",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoadingAdsForLastSubcategory.value = false;
      update();
    }
  }

  /// fun to get commercial ads for  subcategory
  List<CommercialAdModel> commercialAdsPerSubcategory = [];

  RxBool isLoadingCommercialAdsForSubcategory = false.obs;

  void getAllCommercialAdsForSubcategory(
      {required String categoryId, required String subcategoryId}) async {
    try {
      isLoadingCommercialAdsForSubcategory.value = true;
      commercialAdsPerSubcategory.clear();
      final adsSnapshot = await await FirebaseFirestore.instance
          .collection(categoryId)
          .doc(commercialsAddsCollectionKey)
          .collection(commercialsAddsCollectionKey)
          .where('subCategory', isEqualTo: subcategoryId)
          .get();

      for (var adDoc in adsSnapshot.docs) {
        CommercialAdModel ad = CommercialAdModel.fromJson(adDoc.data());

        commercialAdsPerSubcategory.add(ad);
      }
    } catch (e) {
      print('Error parsing ads: $e');
      Get.snackbar("Error", "Failed to load ads: $e",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoadingCommercialAdsForSubcategory.value = false;
      update();
    }
  }


  /// --------------------------------------------- filters logic ---------------------------------------------
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 100000000.0.obs;

}

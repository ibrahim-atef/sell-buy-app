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

  /// --------------------------------------------- filters logic ---------------------------------------------
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 100000000.0.obs;

  // Applied filters map
  final RxMap<String, dynamic> appliedFilters = <String, dynamic>{}.obs;
  List<AdModel> FilteredAdsPerSubcategory = [];

  /// Filters the ads based on selected criteria
  void filterAds(Map<String, String> filters) {
    isLoadingAds.value = true;

    // Debugging: Log the applied filters
    print("Applied Filters: $filters");

    // Mapping to normalize filter keys
    final Map<String, String> filterKeyMapping = {
      'year of production': 'Year of Production',
      'brand': 'Brand',
      'price': 'price',
      'counter': 'Counter',
      'type': 'type',
      'full specifications': 'Full Specifications',
      'boatcustomtype': 'boatCustomType',
      'accessoriescustomtype': 'accessoriesCustomType',
      'sparepartstype': 'sparePartsType',
      'storagecapacity': 'storageCapacity',
      'devicestatus': 'deviceStatus',
      'jobtype': 'jobType',
      'fueltype': 'FuelType',
      'rooms_count': 'rooms_count',
    };

    // Filter ads based on selected criteria
    FilteredAdsPerSubcategory = AdsPerSubcategory.where((ad) {
      // Debug: Log ad details for troubleshooting
      print("Ad Details: ${ad.adExtraDetails}");

      for (var entry in filters.entries) {
        String filterKey = entry.key.toLowerCase().trim();
        String filterValue = entry.value.toLowerCase().trim();

        // Map filter key to the actual ad key
        String actualAdKey = filterKeyMapping[filterKey] ?? filterKey;

        // Handle numeric filters: Price and Counter
        if (actualAdKey == 'price' || actualAdKey == 'Counter') {
          if (!_matchesNumericFilter(ad, actualAdKey, filterValue)) {
            print("Ad skipped (Numeric mismatch for $actualAdKey): ${ad.id}");
            return false;
          }
          continue; // Skip to next filter
        }

        // Check if the ad details contain the key
        if (ad.adExtraDetails == null ||
            !ad.adExtraDetails!.containsKey(actualAdKey)) {
          print("Ad skipped (Missing key: $actualAdKey): ${ad.id}");
          return false;
        }

        // Normalize and compare values
        String adValue =
            ad.adExtraDetails![actualAdKey]?.toLowerCase()?.trim() ?? '';
        if (adValue != filterValue) {
          print("Ad skipped (Value mismatch for $actualAdKey): ${ad.id}");
          return false;
        }
      }

      // If all filters match
      print("Ad passed filters: ${ad.id}");
      return true;
    }).toList();

    isLoadingAds.value = false;

    update();

    FilteredAdsPerSubcategory.length == 0
        ? Get.snackbar(
            'No Changes'.tr,
            'Please try with different filters'.tr,
            snackPosition: SnackPosition.BOTTOM,
          )
        : null;
    // Debug: Log the number of ads after filtering
    print("Filtered Ads Count: ${FilteredAdsPerSubcategory.length}");
  }

  void applySorting(String? sortOption) {
    if (sortOption == null) return;

    FilteredAdsPerSubcategory = List.from(AdsPerSubcategory);
    switch (sortOption) {
      case "lowest_price":
        debugPrint("lowest_price");
        FilteredAdsPerSubcategory.sort((a, b) {
          final priceA = double.tryParse(a.price.toString() ?? '0') ?? 0;
          final priceB = double.tryParse(b.price.toString() ?? '0') ?? 0;
          return priceA.compareTo(priceB); // Ascending order
        });
        debugPrint("lowest_price sorted: ${FilteredAdsPerSubcategory.length}");
        break;

      case "highest_price":
        debugPrint("highest_price");
        FilteredAdsPerSubcategory.sort((a, b) {
          final priceA = double.tryParse(a.price.toString() ?? '0') ?? 0;
          final priceB = double.tryParse(b.price.toString() ?? '0') ?? 0;
          return priceB.compareTo(priceA); // Descending order
        });
        debugPrint("highest_price sorted: ${FilteredAdsPerSubcategory.length}");
        break;

      case "latest":
        debugPrint("latest");
        FilteredAdsPerSubcategory.sort((a, b) {
          final dateA =
              DateTime.tryParse(a.createdAt.toDate().toString() ?? '') ??
                  DateTime(0);
          final dateB =
              DateTime.tryParse(b.createdAt.toDate().toString() ?? '') ??
                  DateTime(0);
          return dateB.compareTo(dateA); // Latest first
        });
        debugPrint("latest sorted: ${FilteredAdsPerSubcategory.length}");
        break;

      case "oldest":
        debugPrint("oldest");
        FilteredAdsPerSubcategory.sort((a, b) {
          final dateA =
              DateTime.tryParse(a.createdAt.toDate().toString() ?? '') ??
                  DateTime(0);
          final dateB =
              DateTime.tryParse(b.createdAt.toDate().toString() ?? '') ??
                  DateTime(0);
          return dateA.compareTo(dateB); // Oldest first
        });
        debugPrint("oldest sorted: ${FilteredAdsPerSubcategory.length}");
        break;

      case "most_matching":
        debugPrint("most_matching");
        FilteredAdsPerSubcategory.sort((a, b) {
          int scoreA = _calculateRelevanceScore(a);
          int scoreB = _calculateRelevanceScore(b);
          return scoreB.compareTo(scoreA); // Higher relevance first
        });
        debugPrint("most_matching sorted: ${FilteredAdsPerSubcategory.length}");
        break;

      default:
        break;
    }

    update(); // Notify UI of changes
  }

  // Filter the ads by selected governorate, region, and district
  void filterAdsByLocation(
    String? governorate,
  ) {
    FilteredAdsPerSubcategory =
        List<AdModel>.from(AdsPerSubcategory).where((ad) {
      final location = ad.locationModel;

      bool matchesGovernorate = governorate == null ||
          location!.governorateArName == governorate ||
          location.governorateEnName == governorate;

      return matchesGovernorate;
    }).toList();
    FilteredAdsPerSubcategory.length == 0
        ? Get.snackbar(
      'No Changes'.tr,
      'Please try with different filters'.tr,
      snackPosition: SnackPosition.BOTTOM,
    )
        : null;


    update(); // Notify the UI
  }

  int _calculateRelevanceScore(AdModel ad) {
    int score = 0;
    appliedFilters.forEach((key, value) {
      String adValue =
          ad.adExtraDetails?[key]?.toString().toLowerCase().trim() ?? '';
      if (adValue == value.toString().toLowerCase().trim()) {
        score++;
      }
    });
    return score;
  }

  clearFilters() {
    FilteredAdsPerSubcategory.clear();

    update();
  }

  /// Helper to match numeric filters (e.g., price and counter)
  bool _matchesNumericFilter(dynamic ad, String key, String filterValue) {
    final range = filterValue.split('-'); // e.g., "1000-5000"
    if (range.length != 2) return false; // Invalid range

    final minValue = double.tryParse(range[0]) ?? 0.0;
    final maxValue = double.tryParse(range[1]) ?? double.infinity;

    final adValue = double.tryParse(ad.adExtraDetails?[key] ?? '');
    if (adValue == null) {
      print("Ad skipped (Invalid numeric value for $key): ${ad.id}");
      return false; // If ad value is not a valid number
    }

    return adValue >= minValue && adValue <= maxValue;
  }

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
}

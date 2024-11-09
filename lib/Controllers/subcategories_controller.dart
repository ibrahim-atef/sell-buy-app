import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Model/ad_model.dart';
import '../Model/categories_subcategories_model.dart';
import '../Services/firestore_methods.dart';
import '../Utilities/my_strings.dart';

class SubCategoriesController extends GetxController {
  List<Subcategory> subcategoryList = <Subcategory>[];
  List<AdModel> AdsPerSubcategory = [];
  RxBool isLoadingSubCategories = false.obs;
  RxBool isLoadingAds = false.obs;

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

  void getAdsForSubcategory(
    String categoryId,
  ) async {
    try {
      isLoadingAds.value = true;
      AdsPerSubcategory.clear();
      final adsSnapshot = await await FirebaseFirestore.instance
          .collection(categoryId)
          .doc(usersAddsCollectionKey)
          .collection(
          usersAddsCollectionKey) // Adjust 'ads' if the sub-collection name is different
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
      isLoadingAds.value = false;
      update();
    }
  }
}

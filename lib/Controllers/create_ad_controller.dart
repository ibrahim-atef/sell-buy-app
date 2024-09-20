import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sell_buy/Model/user_data_model.dart';
import 'package:sell_buy/Services/firestore_methods.dart';

import '../Model/ad_model.dart';
import '../Utilities/categories.dart';
import '../Utilities/my_strings.dart';
import '../Utilities/themes.dart';

class CreateAdController extends GetxController {
  final GetStorage storageBox = GetStorage();
  final picker = ImagePicker();
  List<File>? pickedImages = [];
  final myData = Rxn<UserDataModel>();
  RxBool isAddingAd = false.obs;
  RxBool isUpdatingAd = false.obs;
  final uPicker = ImagePicker();
  List<File>? uPickedImages = [];
  final Map<String, bool> _categoryExpansionStates = {};
  String? selectedCategoryId;
  String? selectedSubcategoryId;

  late final String userId;

  @override
  void onInit() {
    super.onInit();
    userId = storageBox.read(KUid) ?? "";

    getUserData();
  }

  ///--------------------------------------------------------------------------- Function to check if a category is expanded
  bool isCategoryExpanded(String categoryId) {
    return _categoryExpansionStates[categoryId] ?? false;
  }

  ///--------------------------------------------------------------------------- Function to toggle category expansion
  void toggleCategoryExpansion(int index) {
    // Assuming you have a list of categories
    final categoryId = categories[index].id;
    _categoryExpansionStates[categoryId] = !isCategoryExpanded(categoryId);
    update(); // Notify the UI to rebuild
  }

  ///--------------------------------------------------------------------------- Get images from device
  Future<void> getImageFromDevice() async {
    final List<XFile>? pickedFiles =
        await picker.pickMultiImage(imageQuality: 70);
    if (pickedFiles != null) {
      List<File> newImages =
          pickedFiles.map((file) => File(file.path)).toList();
      if (pickedImages != null) {
        pickedImages!.addAll(newImages);
      } else {
        pickedImages = newImages;
      }
      update(); // Update the UI to reflect the picked images
    } else {
      print('No images selected.');
    }
  }

  ///--------------------------------------------------------------------------- Remove an image from the list of picked images
  void removeImageFromImagesList(int index) {
    if (index >= 0 && index < pickedImages!.length) {
      pickedImages!.removeAt(index);
      update(); // Update the UI after removing the image
    }
  }

  /// ---------------------------------------------------------------------------function to set the selected category and subcategory
  void setSelectedCategoryAndSubcategory(
    String categoryId,
    String subcategoryId,
  ) {
    selectedCategoryId = categoryId;
    selectedSubcategoryId = subcategoryId;
    Get.back();
    update();
  }

  /// ---------------------------------------------------------------------------function to get names of category and subcategory after selecting them
  String getCategoryAndSubcategoryNames() {
    if (selectedCategoryId == null || selectedSubcategoryId == null) {
      return 'choose category'.tr;
    }
    final category =
        categories.firstWhere((category) => category.id == selectedCategoryId);
    final subcategory = category.subcategories
        .firstWhere((subcategory) => subcategory.id == selectedSubcategoryId);
    return '${category.name.tr} - ${subcategory.name.tr}';
  }

  /// ---------------------------------------------------------------------------function to get user data
  void getUserData() async {
    final String? uid = await storageBox.read(KUid);
    debugPrint("======================" + uid!);
    if (uid != null) {
      FireStoreMethods.usersCollection.doc(uid).snapshots().listen((event) {
        print("getting user data");

        myData.value = null;
        if (event.exists) {
          myData.value = UserDataModel.fromMap(event);
          update();
        } else {
          debugPrint("getting user data error");
        }
      });
    } else {
      debugPrint("No UID found in authBox");
    }
  }

  Future<void> uploadAd(ItemModel ad) async {
    isAddingAd.value = true; // Start the loading state
    List<String> imageUrls = [];

    try {
      if (pickedImages == null || pickedImages!.isEmpty) {
        throw Exception('Please select at least one image.'.tr);
      }

      for (File image in pickedImages!) {
        String imageUrl =
            await FireStoreMethods.uploadFileToFirebaseStorage(image);
        imageUrls.add(imageUrl); // Add URL to the list
      }

      if (myData.value == null) {
        throw Exception("User data not available.".tr);
      }

      // Set ad details, including owner info from the user data
      ad.imageUrls = imageUrls;
      ad.createdAt = Timestamp.now();
      ad.updatedAt = Timestamp.now();
      ad.ownerName =
          myData.value!.userName!;
      ad.ownerID = myData.value!.uid!;
      ad.ownerPhoneNum=myData.value!.phoneNumber!;

      // Upload the ad to Firestore
      await FireStoreMethods.usersAddsCollection.doc(ad.id).set(ad.toJson());

      // Clear images after successful upload
      pickedImages!.clear();
      isAddingAd.value = false;
      Get.back();
      // Notify user of success
      Get.snackbar(
        "Success".tr,
        "Your ad has been uploaded successfully!".tr,
        snackPosition: SnackPosition.TOP,
      );

    } catch (error) {
      // Handle any errors during the process
      isAddingAd.value = false;
      Get.snackbar("Error", "Failed to upload ad: $error",
          snackPosition: SnackPosition.TOP);
      print("Upload Ad Error: $error");
    }
    finally {
      isAddingAd.value = false;
    }
  }
}

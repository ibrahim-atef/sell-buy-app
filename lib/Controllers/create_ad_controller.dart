import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sell_buy/Model/categories_subcategories_model.dart';
import 'package:sell_buy/Model/user_data_model.dart';
import 'package:sell_buy/Services/firestore_methods.dart';

import '../Model/ad_model.dart';

import '../Model/commercial_ad_model.dart';
import '../Utilities/my_strings.dart';
import '../Utilities/themes.dart';
import 'package:permission_handler/permission_handler.dart';


class CreateAdController extends GetxController {
  final GetStorage storageBox = GetStorage();
  final picker = ImagePicker();
  List<File>? pickedImages = [];
  File? pickedImage;
  final myData = Rxn<UserDataModel>();
  RxBool isAddingAd = false.obs;
  RxBool isUpdatingAd = false.obs;
  final uPicker = ImagePicker();
  List<File>? uPickedImages = [];
  final Map<String, bool> _categoryExpansionStates = {};
  String? selectedCategoryId;
  String? selectedSubcategoryId;
  String? selectedLastSubcategoryId;
  String? selectedCategoryArName;
  String? selectedSubcategoryArName;
  String? selectedLastSubcategoryArName;

  late final String userId;

  @override
  void onInit() {
    super.onInit();
    userId = storageBox.read(KUid) ?? "";
    categoriesList.length == 0 ? getCategoriesAndSubcategories() :  debugPrint("categoriesList is not empty");
    getUserData();
  }

  ///--------------------------------------------------------------------------- Function to check if a category is expanded
  // bool isCategoryExpanded(String categoryId) {
  //   return _categoryExpansionStates[categoryId] ?? false;
  // }

  ///--------------------------------------------------------------------------- Function to toggle category expansion
  // void toggleCategoryExpansion(int index) {
  //   // Assuming you have a list of categories
  //   final categoryId = categoriesList[index].id;
  //   _categoryExpansionStates[categoryId] = !isCategoryExpanded(categoryId);
  //   update(); // Notify the UI to rebuild
  // }

  ///--------------------------------------------------------------------------- Get images from device
  Future<void> getImageFromDevice() async {
  try {
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
  } catch (e) {
    debugPrint(e.toString());
    _showPermissionDeniedDialog();

  }}

  ///--------------------------------------------------------------------------- Get one image from device
  Future<void> getOneImageFromDevice() async {
    try {    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // Use ImageSource.camera if needed
      imageQuality: 70, // Adjust the image quality
    );

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path); // Save the selected image

      update(); // Update UI or notify listeners
    } else {
      print('No image selected.');
    }}
    catch (e) {
      debugPrint(e.toString());
      _showPermissionDeniedDialog();
    }
  }
  ///--------------------------------------------------------------------------- Function to show permission denied dialog
  void _showPermissionDeniedDialog() {
    Get.defaultDialog(
      title: "Permission Denied".tr,
      middleText: "Please allow photo access in settings to select images.".tr,
      textConfirm: "Open Settings".tr,
      textCancel: "Cancel".tr,
      onConfirm: () async {
        // Open app settings for the user to enable permissions manually
        await openAppSettings();
        Get.back(); // Close the dialog after navigating to settings
      },
      onCancel: () {

      }
    );
  }

  ///--------------------------------------------------------------------------- Remove an image from the list of picked images
  void removeImageFromImagesList(int index) {
    if (index >= 0 && index < pickedImages!.length) {
      pickedImages!.removeAt(index);
      update(); // Update the UI after removing the image
    }
  }

  /// ---------------------------------------------------------------------------function to remove the selected img
  void removePickedImage() {
    pickedImage = null;
    update();
  }

  /// ---------------------------------------------------------------------------function to set the selected category and subcategory
  void setSelectedCategoryAndSubcategory(
    String categoryId,
    String subcategoryId,
      String lastSubcategoryId
  ) {
    selectedCategoryId = categoryId;
    selectedSubcategoryId = subcategoryId;
    selectedLastSubcategoryId = lastSubcategoryId;
    Get.back();
    update();
  }

  /// ---------------------------------------------------------------------------function to get names of category and subcategory after selecting them
  String getCategoryAndSubcategoryNames() {
    debugPrint("------- getting category and subcategory names");

    // Check if selectedCategoryId or selectedSubcategoryId is null
    if (selectedCategoryId == null || selectedSubcategoryId == null) {
      return 'choose category'.tr; // Return the translation if any ID is null
    }

    // Get the category using the selectedCategoryId
    final category = categoriesList
        .firstWhere((category) => category.id == selectedCategoryId) as Category;

    // Get the subcategory using the selectedSubcategoryId
    final subcategory = category.subcategories!
        .firstWhere((subcategory) => subcategory.id == selectedSubcategoryId) as Subcategory;

    // Initialize lastSubcategory to null
    LastSubcategory? lastSubcategory;

    // Only look for the last subcategory if selectedLastSubcategoryId is not empty
    if (selectedLastSubcategoryId != null && selectedLastSubcategoryId!.isNotEmpty) {
      lastSubcategory = subcategory.subcategories != null
          ? subcategory.subcategories!.firstWhere(
              (subcategory) => subcategory.id == selectedLastSubcategoryId,

          orElse: () => LastSubcategory(id: "", arName: "", name: "", imagePath: '', categoryId: '', createdAt: Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch) , updatedAt: Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch), subcategoryId:  subcategory.id ) // Return a default Subcategory
      )
          : null;
    }

    // Set the AR names or default to empty string if they are null
    selectedCategoryArName = category.arName;
    selectedSubcategoryArName = subcategory.arName ?? "";
    selectedLastSubcategoryArName = lastSubcategory?.arName ?? ""; // Use null-aware operator

    // Return names based on the current locale
    return Get.locale!.languageCode == "ar"
        ? '${category.arName} - ${subcategory.arName} - ${selectedLastSubcategoryArName}'
        : '${category.name} - ${subcategory.name} - ${lastSubcategory?.name ?? ""}';
  }


  /// ---------------------------------------------------------------------------function to get user data
  void getUserData() async {
    debugPrint("------- getting user data");

    final String? uid = await storageBox.read(KUid);
    if (uid != null) {
      FireStoreMethods.usersCollection.doc(uid).snapshots().listen((event) {
        print("getting user data");

        myData.value = null;
        if (event.exists) {
          myData.value = UserDataModel.fromMap(event);
          update();
        } else {}
      });
    } else {}
  }

  /// ---------------------------------------------------------------------------function to get categories and subcategories from firestore
  List<Category> categoriesList = <Category>[];
  RxBool isLoadingCategories = false.obs;

  // Map to track expanded state of categories and subcategories
  Map<String, bool> categoryExpandedMap = {};
  Map<String, bool> subcategoryExpandedMap = {};

  // Method to get categories and their subcategories (up to 3 levels)
  Future<void> getCategoriesAndSubcategories() async {
    isLoadingCategories.value = true;
    try {
      final categoriesSnapshot = await FireStoreMethods.categoriesCollection.get();
      categoriesList.clear();

      for (var categoryDoc in categoriesSnapshot.docs) {
        Category category = Category.fromMap(categoryDoc.data());
        final subcategoriesSnapshot = await categoryDoc.reference
            .collection(subcategoriesCollectionKey)
            .get();

        List<Subcategory> subcategories = [];
        for (var subcategoryDoc in subcategoriesSnapshot.docs) {
          Subcategory subcategory = Subcategory.fromMap(subcategoryDoc.data());

          // Fetch last-level subcategories
          final lastLevelSnapshot = await subcategoryDoc.reference
              .collection(subcategoriesCollectionKey)
              .get();

          List<LastSubcategory> lastLevelSubcategories = [];
          for (var lastLevelDoc in lastLevelSnapshot.docs) {
            LastSubcategory lastLevelSubcategory = LastSubcategory.fromMap(lastLevelDoc.data());
            lastLevelSubcategories.add(lastLevelSubcategory);
          }

          subcategory.subcategories = lastLevelSubcategories;
          subcategories.add(subcategory);
        }

        category.subcategories = subcategories;
        categoriesList.add(category);
      }

      update();
    } catch (error) {
      print("Error getting categories: $error");
      Get.snackbar("Error", "Failed to load categories",
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoadingCategories.value = false;
    }
  }

  // Methods to toggle expanded state
  void toggleCategoryExpansion(String categoryId) {
    categoryExpandedMap[categoryId] = !(categoryExpandedMap[categoryId] ?? false);
    update();
  }

  void toggleSubcategoryExpansion(String subcategoryId) {
    subcategoryExpandedMap[subcategoryId] = !(subcategoryExpandedMap[subcategoryId] ?? false);
    update();
  }

  // Method to check expansion state
  bool isCategoryExpanded(String categoryId) => categoryExpandedMap[categoryId] ?? false;
  bool isSubcategoryExpanded(String subcategoryId) => subcategoryExpandedMap[subcategoryId] ?? false;
  Map<String , dynamic> extraAdDetails = {};
  Future<void> uploadAd(AdModel ad) async {
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
      ad.imagePath = imageUrls[0];
      ad.createdAt = Timestamp.now();
      ad.updatedAt = Timestamp.now();
      ad.ownerName = myData.value!.userName!;
      ad.ownerID = myData.value!.uid!;
      ad.ownerPhoneNum = myData.value!.phoneNumber!;
      if (selectedCategoryId == null || selectedSubcategoryId == null) {
        Get.snackbar("Error".tr, "Please select category and subcategory".tr);
        return;
      }
      // Upload the ad to Firestore
      await FirebaseFirestore.instance
          .collection(selectedCategoryId!)
          .doc(usersAddsCollectionKey)
          .collection(usersAddsCollectionKey)
          .doc(ad.id)
          .set(ad.toJson());

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
      Get.snackbar("Error".tr, "Failed to upload ad: ".tr+"$error",
          snackPosition: SnackPosition.TOP);
      print("Upload Ad Error: $error");
    } finally {
      isAddingAd.value = false;
    }
  }

  Future<void> uploadCommercialAd(CommercialAdModel ad) async {
    isAddingAd.value = true; // Start the loading state
    String imageUrl = "";

    try {
      // Check if any images have been selected
      if (pickedImage == null) {
        throw Exception('Please select at least one image.'.tr);
      }

      // Upload the image to Firebase Storage and store the URL
      imageUrl = await FireStoreMethods.uploadFileToFirebaseStorage(pickedImage!);

      // Ensure user data is available
      final userData = myData.value;
      if (userData == null) {
        throw Exception("User data not available.".tr);
      }

      // Set ad details, including owner info from the user data
      ad
        ..imagePath = imageUrl
        ..createdAt = Timestamp.now()
        ..updatedAt = Timestamp.now()
        ..ownerName = userData.userName!
        ..ownerID = userData.uid!
        ..ownerPhoneNum = userData.phoneNumber!;

      // Ensure category and subcategory are selected
      if (selectedCategoryId == null || selectedSubcategoryId == null) {
        Get.snackbar("Error".tr, "Please select category and subcategory".tr);
        return;
      }

      // Set category and subcategory details
      ad
        ..category = selectedCategoryId!
        ..subCategory = selectedSubcategoryId!
        ..categoryNameAr = selectedCategoryArName ?? ""
        ..selectedSubcategoryArName = selectedSubcategoryArName ?? "";

      // Upload the ad to Firestore (change the path to use commercialsAdsCollectionKey)
      await FirebaseFirestore.instance
          .collection(selectedCategoryId!)
          .doc(commercialsAddsCollectionKey) // Collection for commercial ads
          .collection(commercialsAddsCollectionKey)
          .doc(ad.id)
          .set(ad.toJson());

      // Clear images after successful upload
      pickedImages?.clear();
      Get.back();

      // Notify the user of success
      Get.snackbar(
        "Success".tr,
        "Your commercial ad has been uploaded successfully!".tr,
        snackPosition: SnackPosition.TOP,
      );
    } catch (error) {
      // Handle any errors during the process
      Get.snackbar("Error".tr, "Failed to upload commercial ad: $error".tr,
          snackPosition: SnackPosition.TOP);
      print("Upload Commercial Ad Error: $error");
    } finally {
      isAddingAd.value = false;
    }
  }


}

import 'package:get/get.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../Utilities/categories.dart';

class CreateAdController extends GetxController {
  final picker = ImagePicker();
  List<File>? pickedImages = [];
  RxBool isAddingAd = false.obs;
  RxBool isUpdatingAd = false.obs;
  final uPicker = ImagePicker();
  List<File>? uPickedImages = [];
  final Map<String, bool> _categoryExpansionStates = {};
  String? selectedCategoryId;
  String? selectedSubcategoryId;

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
    final category = categories.firstWhere((category) => category.id == selectedCategoryId);
    final subcategory = category.subcategories.firstWhere((subcategory) => subcategory.id == selectedSubcategoryId);
    return '${category.name.tr} - ${subcategory.name.tr}';
  }
}

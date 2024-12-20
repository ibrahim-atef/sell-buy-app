import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_buy/Model/user_data_model.dart';
import 'package:sell_buy/Services/firestore_methods.dart';

import '../utilities/my_strings.dart';

class AppSettingController extends GetxController {
  GetStorage storage = GetStorage();
  var langLocal = ara.obs;
  late String? uid = null;
  final myData = Rxn<UserDataModel>();
  RxBool isUserLoading = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    myData.value == null ? initUser() : null;
    langLocal.value = await getLanguage;
    super.onInit();
  }
  Future<void> updatePhoneNumber(String newPhoneNumber) async {
    if (uid != null) {
      try {
        await FireStoreMethods.usersCollection.doc(uid).update({
          'phoneNumber': newPhoneNumber,
        });
        myData.value?.phoneNumber = newPhoneNumber; // Update local data
        update(); // Notify UI
      } catch (e) {
        debugPrint('Error updating phone number: $e');
        throw Exception('Failed to update phone number');
      }
    }
  }
  Future<void> initUser() async {
    // Set loading to true
    isUserLoading.value = true;

    try {
      // Retrieve UID from storage
      uid = await storage.read(KUid);
      if (uid != null && uid!.isNotEmpty) {
        // Fetch user data if UID exists
        await getUserData();
      } else {
        debugPrint('UID is null or empty');
      }
    } catch (e) {
      // Handle any errors in UID retrieval or user data fetching
      debugPrint('Error during initUser: $e');
    } finally {
      // Always stop the loading spinner regardless of success or failure
      isUserLoading.value = false;
      update(); // Update UI after loading completes
    }
  }

  /// Fetch user data from Firestore
  Future<void> getUserData() async {
    debugPrint("------- getting user data");

    if (uid != null) {
      try {
        final doc = await FireStoreMethods.usersCollection.doc(uid).get();
        if (doc.exists) {
          myData.value = UserDataModel.fromMap(doc.data()!);
        } else {
          debugPrint('No user data found');
        }
      } catch (e) {
        debugPrint('Error fetching user data: $e');
      }
    }

    update(); // Update UI with new user data
  }

  ///add localization logic
  void saveLanguage(String lang) async {
    await storage.write("lang", lang);
  }

  Future<String> get getLanguage async {
    return await storage.read("lang") ?? ene;
  }

  /// This function listens to the uid and returns true if it's not null or empty, otherwise false
  bool isUserLoggedIn() {
    return uid != null && uid!.isNotEmpty;
  }

  void changeLanguage(String typeLang) {
    if (langLocal.value == typeLang) {
      return; // No change if the same language is selected
    }
    langLocal.value = typeLang; // Update observable
    saveLanguage(typeLang); // Save new language to storage
    Get.updateLocale(Locale(typeLang)); // Update locale directly

    update(); // Notify the UI about changes
  }


}

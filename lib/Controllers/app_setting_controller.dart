import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_buy/Model/user_data_model.dart';
import 'package:sell_buy/Services/firestore_methods.dart';

import '../utilities/my_strings.dart';

class AppSettingController extends GetxController {
  GetStorage storage = GetStorage();
  var langLocal = ara;
  late String? uid = null;
  final myData = Rxn<UserDataModel>();
  RxBool isUserLoading = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    initUser();
    super.onInit();
  }

  Future<void> initUser() async {
    isUserLoading.value = true;
    uid = await storage.read(KUid);
    if (uid != null && uid!.isNotEmpty) {
      getUserData();
      isUserLoading.value = false;
    } else {
      // Handle the case when uid is null or empty, possibly show error or ask the user to login.
      print('UID is null or empty');
      isUserLoading.value = false;
    }

    update();
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
    saveLanguage(typeLang);
    if (langLocal == typeLang) {
      return;
    }

    if (typeLang == ara) {
      langLocal = ara;
      saveLanguage(ara);
    } else {
      langLocal = ene;
      saveLanguage(ene);
    }
    update();
  }

  void getUserData() async {
    debugPrint("------- getting user data");

    final String? uid = await storage.read(KUid);
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
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utilities/my_strings.dart';

class AppSettingController extends GetxController{
  GetStorage storage = GetStorage();
  var langLocal = ara;


  ///add localization logic
  void saveLanguage(String lang) async {
    await storage.write("lang", lang);
  }

  Future<String> get getLanguage async {
    return await storage.read("lang") ?? ene;
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
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../View/Screens/MainLayoutScreens/Home/home_screen.dart';
import '../../View/Screens/MainLayoutScreens/Search/search_screen.dart';
import '../../View/Screens/MainLayoutScreens/CreateAd/create_ad_screen.dart';
import '../../View/Screens/MainLayoutScreens/Commercial/commercial_screen.dart';
import '../../View/Screens/MainLayoutScreens/Profile/profile_screen.dart';
import '../Routes/routes.dart';
import '../Utilities/my_strings.dart';
import '../View/Screens/MainLayoutScreens/CreateAd/select_type_of_screen.dart';

class MainLayoutController extends GetxController {
  int currentIndex = 0;
  final GetStorage storageBox = GetStorage();
  late final String healthInstitutionId;
  final List<Widget> children = [
    HomeScreen(),
    SearchScreen(),
    SelectTypeOfAdScreen(),
    CommercialScreen(),
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    final authValue = GetStorage().read(KUid);
    if (index == 2) {
      if (authValue == null) {
        Get.toNamed(Routes.LoginScreen,);
      } else {
        Get.toNamed(Routes.selectTypeOfAdScreen);
        update();
      }
    } else {
      currentIndex = index;
      update();
    }
  }
}
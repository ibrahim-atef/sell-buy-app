import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../View/Screens/MainLayoutScreens/Home/home_screen.dart';
import '../../View/Screens/MainLayoutScreens/Search/search_screen.dart';
import '../../View/Screens/MainLayoutScreens/CreateAd/create_ad_screen.dart';
import '../../View/Screens/MainLayoutScreens/Commercial/commercial_screen.dart';
import '../../View/Screens/MainLayoutScreens/Profile/profile_screen.dart';

class MainLayoutController extends GetxController {
  int currentIndex = 0;
  final List<Widget> children = [
    HomeScreen(),
    SearchScreen(),
    CreateAdScreen(),
    CommercialScreen(),
    ProfileScreen(),
  ];

  void onTabTapped(int index) {
    currentIndex = index;
    update();
  }
}

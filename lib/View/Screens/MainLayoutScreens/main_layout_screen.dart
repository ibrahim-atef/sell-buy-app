import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/main_layout_controller.dart';
import 'package:sell_buy/View/Widgets/SearchBar/search_bar_widget.dart';

import '../../../Controllers/home_controller.dart';
import '../../../Utilities/icons.dart';
import '../../../Utilities/themes.dart';
import 'CreateAd/select_type_of_screen.dart';
import 'Home/home_screen.dart';
import 'Search/search_screen.dart';
import 'CreateAd/create_ad_screen.dart';
import 'Commercial/commercial_screen.dart';
import 'Profile/profile_screen.dart';

class MainLayoutScreen extends StatelessWidget {
  final mainLayoutController = Get.put(MainLayoutController());
  final homeController = Get.put(HomeController());
  final List<Widget> _children = [
    HomeScreen(),
    SearchScreen(),
    SelectTypeOfAdScreen(),
    CommercialScreen(),
    ProfileScreen(),
  ];

  DateTime? lastExitTime;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return GetBuilder<MainLayoutController>(
          builder: (_) {
            return WillPopScope(
              onWillPop: () async {
                if (homeController.searchText.isNotEmpty) {
                  // Clear search query before exit
                  homeController.clearSearchQuery();
                  return false; // Prevent the pop action
                } else {
                  // Handle exit confirmation
                  return await _onWillPop();
                }
              },
              child: Scaffold(
                appBar: mainLayoutController.currentIndex == 4
                    ? null
                    : AppBar(
                  elevation: .5,
                  title: SearchBarWidget(),
                ),
                body: _children[mainLayoutController.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  onTap: mainLayoutController.onTabTapped,
                  currentIndex: mainLayoutController.currentIndex,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedItemColor: Colors.black,
                  selectedLabelStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Rubik"),
                  unselectedLabelStyle:
                  const TextStyle(fontSize: 12, fontFamily: "Rubik"),
                  unselectedItemColor: backgroundColor,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(IconBroken.Home),
                      label: 'Home'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconBroken.Search),
                      label: 'Search'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconBroken.Paper_Upload),
                      label: 'Create AD'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconBroken.Buy),
                      label: 'Commercial'.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconBroken.Profile),
                      label: 'Profile'.tr,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    DateTime currentTime = DateTime.now();

    if (lastExitTime == null ||
        currentTime.difference(lastExitTime!) > Duration(seconds: 2)) {
      lastExitTime = currentTime;
      Get.snackbar(
        'Exit App'.tr,
        'Press back again to exit'.tr,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
      return false; // Prevent the pop action
    }
    return true; // Allow the pop action
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/main_layout_controller.dart';
import 'package:sell_buy/View/Widgets/SearchBar/search_bar_widget.dart';

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
  final List<Widget> _children = [
    HomeScreen(),
    SearchScreen(),
    SelectTypeOfAdScreen(),
    CommercialScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLayoutController>(
      builder: (_) {
        return Scaffold(
          appBar: mainLayoutController.currentIndex == 4 ? null : AppBar(elevation: .5,
            title: SearchBarWidget (),
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
                fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "Rubik"),
            unselectedLabelStyle:
                const TextStyle(fontSize: 12, fontFamily: "Rubik"),
            unselectedItemColor: backgroundColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Search,
                ),
                label: 'Search'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: 'Create AD'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Buy,
                ),
                label: 'Commercial'.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Profile,
                ),
                label: 'Profile'.tr,
              ),
            ],
          ),
        );
      },
    );
  }
}

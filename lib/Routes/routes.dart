import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/View/Screens/Authentication/login_screen.dart';

import '../View/Screens/Authentication/register_screen.dart';
import '../View/Screens/MainLayoutScreens/CreateAd/external_screens/category_selection_screen.dart';
import '../View/Screens/MainLayoutScreens/CreateAd/create_comercial_ad_screen.dart';
import '../View/Screens/MainLayoutScreens/CreateAd/select_type_of_screen.dart';
import '../View/Screens/MainLayoutScreens/Home/home_screen.dart';
import '../View/Screens/MainLayoutScreens/Profile/edit_profile_screen.dart';
import '../View/Screens/MainLayoutScreens/Profile/favourite_ads_screen.dart';
import '../View/Screens/MainLayoutScreens/Profile/recently_viewed_ads.dart';
import '../View/Screens/MainLayoutScreens/Search/search_screen.dart';
import '../View/Screens/MainLayoutScreens/CreateAd/create_ad_screen.dart';
import '../View/Screens/MainLayoutScreens/Commercial/commercial_screen.dart';
import '../View/Screens/MainLayoutScreens/Profile/profile_screen.dart';
import '../View/Screens/MainLayoutScreens/main_layout_screen.dart';
import '../View/Screens/utilites_screen/no_internet_screen.dart';
import '../view/screens/splash/splash_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: Routes.SplashScreen, page: () => SplashScreen()),
    GetPage(name: Routes.HomeScreen, page: () => HomeScreen()),
    GetPage(name: Routes.SearchScreen, page: () => SearchScreen()),
    GetPage(name: Routes.ProfileScreen, page: () => ProfileScreen()),
    GetPage(
      name: Routes.CreateAdScreen,
      page: () => CreateAdScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(name: Routes.CommercialScreen, page: () => CommercialScreen()),
    GetPage(name: Routes.MainLayoutScreen, page: () => MainLayoutScreen()),
    GetPage(
      name: Routes.RegisterScreen,
      page: () => RegisterScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
      preventDuplicates: true,
    ),
    GetPage(
      name: Routes.LoginScreen,
      page: () => LoginScreen(isSignedOut: false,),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
      preventDuplicates: true,
      curve: Curves.fastEaseInToSlowEaseOut,
    ),
    GetPage(
      name: Routes.CategorySelectionScreen,
      page: () => CategorySelectionScreen(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.EditProfileScreen,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: Routes.noInternetScreen,
      page: () => NoInternetScreen(),
    ),
    GetPage(
      name: Routes.selectTypeOfAdScreen,
      page: () => SelectTypeOfAdScreen(),
    ),
    GetPage(
      name: Routes.createCommercialAdScreen,
      page: () => CreateCommercialAdScreen(),
    ),
    GetPage(
      name: Routes.recentlyViewedAds,
      page: () => RecentlyViewedAds(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 500),
    ),   GetPage(
      name: Routes.favoriteAdsScreen,
      page: () => FavouriteAdsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 500),
    ),

  ];
}

class Routes {
  static const SplashScreen = "/SplashScreen";
  static const HomeScreen = "/HomeScreen";
  static const SearchScreen = "/SearchScreen";
  static const ProfileScreen = "/ProfileScreen";
  static const CreateAdScreen = "/CreateAdScreen";
  static const CommercialScreen = "/CommercialScreen";
  static const MainLayoutScreen = "/MainLayoutScreen";
  static const RegisterScreen = "/RegisterScreen";
  static const LoginScreen = "/LoginScreen";
  static const CategorySelectionScreen = "/CategorySelectionScreen";
  static const EditProfileScreen = "/EditProfileScreen";
  static const noInternetScreen = "/NoInternetScreen";
  static const selectTypeOfAdScreen = "/SelectTypeOfAdScreen";
  static const createCommercialAdScreen = "/CreateCommercialAdScreen";
  static const recentlyViewedAds = "/RecentlyViewedAds";
  static const favoriteAdsScreen = "/FavouriteAdsScreen";
}

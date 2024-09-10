
import 'package:get/get.dart';

import '../View/Screens/MainLayoutScreens/Home/home_screen.dart';
import '../View/Screens/MainLayoutScreens/Search/search_screen.dart';
import '../View/Screens/MainLayoutScreens/CreateAd/create_ad_screen.dart';
import '../View/Screens/MainLayoutScreens/Commercial/commercial_screen.dart';
import '../View/Screens/MainLayoutScreens/Profile/profile_screen.dart';
import '../View/Screens/MainLayoutScreens/main_layout_screen.dart';
import '../view/screens/splash/splash_screen.dart';



class AppRoutes {
  static final routes = [
  GetPage(name: Routes.SplashScreen, page: () => SplashScreen()),
  GetPage(name: Routes.HomeScreen, page: () => HomeScreen()),
  GetPage(name: Routes.SearchScreen, page: () => SearchScreen()),
  GetPage(name: Routes.ProfileScreen, page: () => ProfileScreen()),
  GetPage(name: Routes.CreateAdScreen, page: () => CreateAdScreen()),
  GetPage(name: Routes.CommercialScreen, page: () => CommercialScreen()),
  GetPage(name: Routes.MainLayoutScreen, page: () => MainLayoutScreen()),


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


}

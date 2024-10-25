import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_buy/Controllers/home_controller.dart';
import 'package:sell_buy/Controllers/internet_controller.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_loader_component.dart';
import 'package:sell_buy/utilities/themes.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../../../Routes/routes.dart';
import '../../../Utilities/my_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final homeController = Get.put(HomeController());
  final internetController = Get.put(InternetController());

  @override
  void initState() {
    super.initState();
    final authValue = GetStorage().read(KUid);

    // Check internet connection first
    internetController.checkConnection().then((_) {
      // If no internet, navigate to NoInternetScreen
      if (!internetController.isConnected.value) {
        Get.offNamed(Routes.noInternetScreen);
        return;
      }

      // Start loading categories if connected
      // homeController.loadCategories();

      // Listen for changes in loading state
      ever(homeController.isLoadingCategories, (isLoading) {
        if (!isLoading) {
          // Once loading is finished, navigate based on authValue
          if (authValue == null) {
            Get.offNamed(Routes.MainLayoutScreen);
          } else {
            Get.offNamed(Routes.MainLayoutScreen);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: TextComponent(
          text: "بيع و اشتر",
          size: Get.width * 0.14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      floatingActionButton: homeController.isLoadingCategories.value
          ? Padding(
        padding: const EdgeInsets.only(bottom: 22),
        child: LoaderComponent(),
      )
          : SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

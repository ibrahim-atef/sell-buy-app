import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/utilities/themes.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../../../Routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   final authValue = GetStorage().read(KRole);
  //   if (authValue == null) {
  //
  //   } else if (authValue == usersCollectionKey) {
  //     Get.put(UserController());
  //   } else if (authValue == healthInstitutionCollectionKey) {
  //     Get.put(HealthInstitutionController());
  //   } else {
  //
  //   }
  //   Future.delayed(Duration(seconds: 3), () {
  //
  //     if (authValue == null) {
  //       Get.offNamed(Routes.loginScreen);
  //     } else if (authValue == usersCollectionKey) {
  //       Get.offNamed(Routes.patientsListScreen);
  //     } else if (authValue == healthInstitutionCollectionKey) {
  //       Get.offNamed(Routes.homeHealthInstitutionScreen);
  //     } else {
  //       Get.offNamed(Routes.loginScreen);
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(Routes.MainLayoutScreen);
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
        fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,
          )),
    );
  }
}

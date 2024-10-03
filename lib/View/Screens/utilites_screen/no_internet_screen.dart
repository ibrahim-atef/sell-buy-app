import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sell_buy/view/widgets/utilities_widgets/text_Component.dart';

import '../../../Controllers/internet_controller.dart';
import '../../../Routes/routes.dart';

class NoInternetScreen extends StatelessWidget {
    NoInternetScreen({super.key});
  final internetController = Get.put(InternetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<InternetController>(builder: (_) {return SizedBox(width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image (SVG)
            SvgPicture.asset(
              'assets/Icons/no-net.svg', // Your provided image path
              height: 150,
            ),
            const SizedBox(height: 30),

            // No Internet Text
            TextComponent(
              text: 'لا يوجد اتصال بالإنترنت!',
              size: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 15),

            // Instruction Text
            TextComponent(
                text: 'يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى.',
                size: 16,
                color: Colors.grey,
                fontWeight: FontWeight.normal
            ),
            const SizedBox(height: 30),

            // Retry Button
            ElevatedButton(
              onPressed: () async {
                await internetController.checkConnection();
                if (internetController.isConnected.value) {
               Get.offNamed(Routes.SplashScreen)  ; // Go back if connected
                } else {
                  Get.snackbar(
                    'Warning'.tr,
                    "There's no internet connection".tr,
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15), // Button size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextComponent(
                  text:"try again".tr,
                  size: 16,
                  color: Colors.white, fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(height: 20),

            // Contact Us Link
            TextButton(
              onPressed: () {
                // Contact Us action
              },
              child: TextComponent(
                text: "call us".tr,
                size: 16,
                color: Colors.blue, fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );  },),
    );
  }
}
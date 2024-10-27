import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart';
import '../../../utilities/themes.dart';
import '../../Widgets/utilities_widgets/button_component.dart';


class ListenAccountStatusScreen extends StatelessWidget {
  final Widget childScaffold;
  final dynamic getXController; // The dynamic controller to be passed in

  ListenAccountStatusScreen({
    required this.childScaffold,
    required this.getXController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final myData = getXController.myData.value;

      if ( !myData.isActivated??false) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Account Not Activated".tr,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            actions: [
              ButtonComponent(
                onPressed: () {
                  Get.toNamed(Routes.ProfileScreen);
                },
                text: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, color: white),
                  ],
                ),
                width: Get.width * .15,
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your account has been suspended.\n Try contacting the admin"
                        .tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(  fontSize: 22,
                      color: mainColor,
                      fontWeight: FontWeight.bold,),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.no_accounts_rounded,
                      size: 100,
                      color: mainColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return childScaffold;
      }
    });
  }
}

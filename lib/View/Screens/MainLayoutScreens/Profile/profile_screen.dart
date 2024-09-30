import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/auth_controller.dart';
import 'package:sell_buy/Controllers/home_controller.dart';
import 'package:sell_buy/Model/user_data_model.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/Utilities/themes.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/button_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/custom_shimmer_widget.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../Controllers/app_setting_controller.dart';
import '../../../../Utilities/my_strings.dart';
import '../../../../routes/routes.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final settingController = Get.put(AppSettingController());

  final authController = Get.put(AuthController());

  @override
  void initState() {
    settingController.onInit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AppSettingController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.07),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    // Handle the loading state
                    if (settingController.isUserLoading.value) {
                      // Show shimmer when loading user data
                      return _buildUserInfoLoadingShimmer();
                    }

                    // Check if UID is null or empty
                    if (settingController.uid == null || settingController.uid!.isEmpty) {
                      return _buildHelloSection();
                    }

                    // If user data is being fetched but not yet available
                    if (settingController.myData.value == null) {
                      return _buildUserInfoLoadingShimmer();
                    }

                    // Once data is loaded, show the user info section
                    return _buildUserInfoSection(userData: settingController.myData.value!);
                  }),
                ),

                SizedBox(height: 12),
                !settingController.isUserLoggedIn()
                    ? ButtonComponent(
                        backgroundColor: backgroundColor,
                        onPressed: () {
                          Get.toNamed(Routes.LoginScreen);
                        },
                        text: TextComponent(
                            text: "تسجيل الدخول".tr,
                            size: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        width: Get.width * 0.9,
                      )
                    : SizedBox.shrink(),
                settingController.isUserLoggedIn()
                    ? SizedBox.shrink()
                    : SizedBox(height: 20),
                settingController.isUserLoggedIn()
                    ? SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextComponent(
                            text: "Don't have an account?".tr,
                            size: 12,
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the register screen
                              Get.toNamed(Routes.RegisterScreen);
                            },
                            child: TextComponent(
                              text: 'Register here'.tr,
                              size: 14,
                              color: backgroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                SizedBox(height: Get.height * 0.03),
                Container(
                  height: 6,
                  color: baseColorShimmer,
                ),
                _buildOptionsSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserInfoSection({required UserDataModel userData}) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: baseColorShimmer,
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            TextComponent(
                text: 'Welcome'.tr + userData.userName!,
                size: 16,
                color: mainColor,
                fontWeight: FontWeight.bold),
            TextComponent(
                text: "Thank you for using our application.".tr,
                size: 12,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
            TextComponent(
                text: "${userData.email}\n${userData.phoneNumber}",
                size: 12,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
          ],
        ),
      ],
    );
  }

  Widget _buildHelloSection() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: baseColorShimmer,
          child: Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextComponent(
                text: "مرحباً بك",
                size: 16,
                color: mainColor,
                fontWeight: FontWeight.bold),
            TextComponent(
                text:
                    "قم بتسجيل الدخول أو إنشاء حساب جديد\n لشراء و بيع كل شيء",
                size: 12,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
          ],
        ),
      ],
    );
  }

  Widget _buildUserInfoLoadingShimmer() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: baseColorShimmer,
          child: CustomShimmer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFFE5E5EA),
              ),
              width: 50,
              height: 50,
            ),
            baseColor: const Color(0xFFE5E5EA),
            highlightColor: const Color(0xFFF5F5F5),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomShimmer(
              baseColor: const Color(0xFFE5E5EA),
              highlightColor: const Color(0xFFF5F5F5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: const Color(0xFFE5E5EA),
                ),
                width: 50,
                height: 10,
              ),
            ),
            SizedBox(height: 4),
            CustomShimmer(
              baseColor: const Color(0xFFE5E5EA),
              highlightColor: const Color(0xFFF5F5F5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: const Color(0xFFE5E5EA),
                ),
                width: Get.width * .65,
                height: 10,
              ),
            ),
            SizedBox(height: 4),
            CustomShimmer(
              baseColor: const Color(0xFFE5E5EA),
              highlightColor: const Color(0xFFF5F5F5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: const Color(0xFFE5E5EA),
                ),
                width: Get.width * .5,
                height: 10,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildOptionsSection() {
    return Column(
      children: [
        _buildOptionItem(Icons.visibility, 'recently viewed'.tr, () {}),
        // "Recently Viewed"
        _buildOptionItem(IconBroken.Edit, 'Edit Profile '.tr, () {
     settingController.myData.value== null? Get.snackbar( '', 'please wait'.tr):     Get.toNamed(Routes.EditProfileScreen,);
        }),
        // "Saved Searches"
        GetBuilder<AppSettingController>(builder: (appSettingController) {
          return _buildOptionItem(Icons.language,
              appSettingController.langLocal == ara ? 'العربية' : 'English',
              () {
            // Switch language directly
            String newLang = appSettingController.langLocal == ara ? ene : ara;
            appSettingController.changeLanguage(newLang);
            Get.updateLocale(Locale(newLang));
          });
        }),

        // "Language"

        // "List of Representatives"
        _buildOptionItem(Icons.headset_mic, 'Technical Support'.tr, () {}),
        // "Technical Support"
        _buildOptionItem(Icons.security, 'Terms and Conditions'.tr, () {}),
        GetBuilder<AuthController>(
          builder: (authController) {
            return GetBuilder<AppSettingController>(
              builder: (appSettingController) {
                return !appSettingController.isUserLoggedIn()
                    ? SizedBox.shrink()
                    : _buildOptionItem(IconBroken.Logout, 'Logout'.tr, () {
                        authController.logout();
                      });
              },
            );
          },
        ),
        // "Rules and Terms"
      ],
    );
  }

  Widget _buildOptionItem(
      IconData icon, String title, final Function() onPressed) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: mainColor, size: 28),
          title: TextComponent(
            text: title,
            size: 16,
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
          trailing: const Icon(
            Icons.chevron_right,
            size: 28,
          ),
          onTap: onPressed,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: white,
        ),
        Divider(
          color: baseColorShimmer,
        )
      ],
    );
  }
}

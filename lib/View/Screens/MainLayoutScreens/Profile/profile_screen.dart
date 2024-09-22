import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Controllers/auth_controller.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/Utilities/themes.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/button_component.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';

import '../../../../Controllers/app_setting_controller.dart';
import '../../../../routes/routes.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final settingController = Get.put(AppSettingController());
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.07),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildUserInfoSection(),
            ),
            SizedBox(height: 12),
            ButtonComponent(
              backgroundColor: backgroundColor,
              onPressed: () {Get.toNamed(Routes.LoginScreen);},
              text: TextComponent(
                  text: "تسجيل الدخول".tr,
                  size: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              width: Get.width * 0.9,
            ),
            SizedBox(height: 20),
            Row(
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
      ),
    );
  }

  Widget _buildUserInfoSection() {
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

  Widget _buildOptionsSection() {
    return Column(
      children: [
        _buildOptionItem(Icons.visibility, 'شاهدت مؤخراً', () {}),
        // "Recently Viewed"
        _buildOptionItem(Icons.bookmark, 'البحث المحفوظ', () {}),
        // "Saved Searches"
        _buildOptionItem(Icons.language, 'English', () {}),
        // "Language"

        // "List of Representatives"
        _buildOptionItem(Icons.headset_mic, 'الدعم الفني', () {}),
        // "Technical Support"
        _buildOptionItem(Icons.security, 'القواعد والشروط', () {}),
        GetBuilder<AuthController>(
          builder: (_) {
            return _buildOptionItem(IconBroken.Logout, 'تسجيل الخروج', () {authController.logout();});
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

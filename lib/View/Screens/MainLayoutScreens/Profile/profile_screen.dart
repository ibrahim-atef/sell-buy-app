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
import 'package:url_launcher/url_launcher.dart';
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
                    if (settingController.uid == null ||
                        settingController.uid!.isEmpty) {
                      return _buildHelloSection();
                    }

                    // If user data is being fetched but not yet available
                    if (settingController.myData.value == null) {
                      return _buildUserInfoLoadingShimmer();
                    }

                    // Once data is loaded, show the user info section
                    return _buildUserInfoSection(
                        userData: settingController.myData.value!);
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
                            text: "sign in".tr,
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
                text: "Welcome".tr,
                size: 16,
                color: mainColor,
                fontWeight: FontWeight.bold),
            TextComponent(
                text:
                    "Please login or create an account\n to purchase and sell everything"
                        .tr,
                size: 12,
                maxLines: 2,
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
    return GetBuilder<AppSettingController>(
      builder: (_) {
        return Column(
          children: [
            buildOptionItem(Icons.visibility, 'Recently viewed'.tr, () {
              settingController.myData.value == null ||
                  !settingController.isUserLoggedIn()
                  ? Get.toNamed(Routes.LoginScreen)
                  : Get.toNamed(
                Routes.recentlyViewedAds,
              );
            }),
            // "Recently Viewed"
            buildOptionItem(
              Icons.favorite,
              'Favorites'.tr,
                  () {
                settingController.myData.value == null ||
                    !settingController.isUserLoggedIn()
                    ? Get.toNamed(Routes.LoginScreen)
                    : Get.toNamed(
                  Routes.favoriteAdsScreen,
                );
              },
            ),
            buildOptionItem(IconBroken.Edit, 'Edit Profile '.tr, () {
              settingController.myData.value == null ||
                  !settingController.isUserLoggedIn()
                  ? Get.toNamed(Routes.LoginScreen)
                  : Get.toNamed(
                Routes.EditProfileScreen,
              );
            }),
            // "Saved Searches"
            buildOptionItem(
              Icons.language,
              settingController.langLocal.value == ara ? 'العربية' : 'English',
                  () {
                // Switch language directly
                String newLang =
                settingController.langLocal.value == ara ? ene : ara;
                settingController.changeLanguage(
                    newLang); // This will now update immediately
              },
            ),

            // "Language"

            // "List of Representatives"
            GetBuilder<AuthController>(
              builder: (_) {
                return buildOptionItem(
                    Icons.headset_mic, 'Technical Support'.tr, () {
                  authController.contactAdmin(
                      subject: "Technical Support",
                      body: "I wanna contact technical support");
                });
              },
            ),
            // "Technical Support"

            // Updated Terms and Conditions button
            buildOptionItem(Icons.security, 'Terms and Conditions'.tr, () async {
              const String privacyPolicyUrl = "https://sites.google.com/view/sellbuyapp/%D8%A7%D9%84%D8%B5%D9%81%D8%AD%D8%A9-%D8%A7%D9%84%D8%B1%D8%A6%D9%8A%D8%B3%D9%8A%D8%A9";

              // Launch the Privacy Policy URL
              if (await canLaunchUrl(Uri.parse(privacyPolicyUrl))) {
                await launchUrl(Uri.parse(privacyPolicyUrl),
                    mode: LaunchMode.externalApplication);
              } else {
                Get.snackbar(
                  'Error',
                  'Could not open Terms and Conditions',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            }),

            GetBuilder<AuthController>(
              builder: (authController) {
                return GetBuilder<AppSettingController>(
                  builder: (appSettingController) {
                    return !appSettingController.isUserLoggedIn()
                        ? SizedBox.shrink()
                        : buildOptionItem(IconBroken.Logout, 'Logout'.tr, () {
                      authController.logout();
                    });
                  },
                );
              },
            ),
            // "Rules and Terms"
          ],
        );
      },
    );
  }

}

Widget buildOptionItem(icon, String title, final Function() onPressed,
    {bool? hasDivider = true, double? height}) {
  return Column(
    children: [
      ListTile(
        minTileHeight: height ?? Get.height * .06,
        leading:icon==null ?null: Icon(icon ?? null, color: mainColor, size:  28),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: white,
      ),
      hasDivider == true
          ? Divider(
              color: baseColorShimmer,
            )
          : SizedBox.shrink()
    ],
  );
}

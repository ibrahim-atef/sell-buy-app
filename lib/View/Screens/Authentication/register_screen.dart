import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/auth_controller.dart';
import '../../../Model/user_data_model.dart';
import '../../../Routes/routes.dart';
import '../../../Utilities/icons.dart';
import '../../../Utilities/my_strings.dart';
import '../../../Utilities/themes.dart';
import '../../Widgets/utilities_widgets/custom_text_from_field.dart';
import '../../Widgets/utilities_widgets/button_component.dart';
import '../../Widgets/utilities_widgets/text_Component.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  final userNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController(); // New controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            IconBroken.Arrow___Right_2,
            color: black,
          ),
        ),
      ),
      backgroundColor: white,
      body: Center(
        child: GetBuilder<AuthController>(
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextComponent(
                            text: 'Create a new account'.tr,
                            size: 24,
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextComponent(
                            text:
                                'By registering, you will get full access to all benefits Our advantages: Faster'
                                    .tr,
                            size: 18,
                            color: black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      CustomTextFromField(
                        controller: userNameController,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter your username'.tr;
                          if (!RegExp(usernamePattern).hasMatch(value))
                            return 'User name must be letters only'.tr;
                          return null;
                        },
                        hintText: 'user name'.tr,
                        textInputType: TextInputType.text,
                        prefixIcon: SizedBox.shrink(),
                        suffixIcon: SizedBox.shrink(),
                      ),
                      SizedBox(height: 10),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: CustomTextFromField(
                          controller: phoneNumberController,
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please enter phone number'.tr;
                            if (!RegExp(phonePattern).hasMatch(
                                authController.countryCode.value + value))
                              return 'Please enter a valid phone number'.tr;
                            return null;
                          },
                          hintText: 'xxxxxxxx'.tr,
                          textInputType: TextInputType.phone,
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CountryCodePicker(
                                padding: EdgeInsets.zero,
                                flagWidth: Get.width * .045,
                                onChanged: (code) {
                                  authController
                                      .updateCountryCode(code.dialCode!);
                                },
                                initialSelection: 'SA',
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 29,
                                color: mainColor.withOpacity(.3),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                          suffixIcon: SizedBox.shrink(),
                        ),
                      ),
                      SizedBox(height: 10),
                      CustomTextFromField(
                        controller: emailController,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter your email'.tr;
                          if (!RegExp(emailPattern).hasMatch(value))
                            return 'Please enter a valid email address'.tr;
                          return null;
                        },
                        hintText: 'E-mail'.tr,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: SizedBox.shrink(),
                        suffixIcon: SizedBox.shrink(),
                      ),
                      SizedBox(height: 10),
                      GetBuilder<AuthController>(builder: (_) {
                        return CustomTextFromField(
                          controller: passwordController,
                          obscureText: !authController.isVisibility2,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your password'.tr;
                            if (!RegExp(passwordPattern).hasMatch(value))
                              return 'The password must be at least 8 characters\n long and contain one letter and one number'
                                  .tr;
                            return null;
                          },
                          hintText: 'password'.tr,
                          textInputType: TextInputType.text,
                          prefixIcon: SizedBox.shrink(),
                          suffixIcon: InkWell(
                            onTap: () {
                              authController.visibility2();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 1,
                                  height: 29,
                                  color: mainColor.withOpacity(.3),
                                ),
                                SizedBox(width: 5),
                                !authController.isVisibility2
                                    ? Icon(Icons.visibility_outlined,
                                        color: mainColor.withOpacity(.5))
                                    : Icon(Icons.visibility_off_outlined,
                                        color: mainColor.withOpacity(.5)),
                                // Corrected icon name
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 10),
                      // Re-enter Password Field
                      GetBuilder<AuthController>(builder: (_) {
                        return CustomTextFromField(
                          controller: reEnterPasswordController,
                          obscureText: !authController.isVisibility,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please re-enter your password'.tr;
                            if (value != passwordController.text)
                              return 'Passwords do not match'.tr;
                            return null;
                          },
                          hintText: 'Re-enter password'.tr,
                          textInputType: TextInputType.text,
                          prefixIcon: SizedBox.shrink(),
                          suffixIcon: InkWell(
                            onTap: () {
                              authController.visibility();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 1,
                                  height: 29,
                                  color: mainColor.withOpacity(.3),
                                ),
                                SizedBox(width: 5),
                                !authController.isVisibility
                                    ? Icon(Icons.visibility_outlined,
                                        color: mainColor.withOpacity(.5))
                                    : Icon(Icons.visibility_off_outlined,
                                        color: mainColor.withOpacity(.5)),
                                // Corrected icon name
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 10),
                      GetBuilder<AuthController>(builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              visualDensity: VisualDensity.comfortable,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: authController.agreePolicies,
                              onChanged: (bool? value) {
                                authController
                                    .settAgreePolicyVal(value ?? false);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              side: BorderSide(
                                color: mainColor,
                                width: 2,
                              ),
                            ),
                            SizedBox(width: 5),
                            TextComponent(
                              text: "I agree to the ".tr,
                              size: 17,
                              color: mainColor,
                              fontWeight: FontWeight.normal,
                              textDecoration: TextDecoration.none,
                            ),
                            GestureDetector(
                              onTap: _launchUrl,
                              child: TextComponent(
                                text: "policies".tr,
                                size: 17,
                                color: mainColor,
                                fontWeight: FontWeight.normal,
                                textDecoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        );
                      }),
                      SizedBox(height: 20),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * .06),
                        child: GetBuilder<AuthController>(builder: (_) {
                          return ButtonComponent(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                String phoneNumber =
                                    authController.countryCode.value +
                                        phoneNumberController.text;

                                if (!authController.agreePolicies) {
                                  Get.snackbar(
                                    "privacy policy".tr,
                                    "Please agree to our policies".tr,
                                    duration: Duration(seconds: 3),
                                  );
                                  return;
                                }

                                UserDataModel userModel = UserDataModel(
                                  userName: userNameController.text,
                                  phoneNumber: phoneNumber,
                                  email: emailController.text,
                                  isActivated: true,
                                  // Add any additional fields here if needed
                                );

                                authController.registerNewUserWithEmail(
                                  userModel: userModel,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: authController.isSignUpLoading.value
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: Get.width*.2),
                                    child: LinearProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Register'.tr,
                                    style: TextStyle(
                                      color: white,
                                      fontFamily: 'Rubik',
                                    ),
                                  ),
                            width: double.infinity,
                          );
                        }),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextComponent(
                            text: "You Have an account already?".tr,
                            size: 12,
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: TextComponent(
                              text: 'Click here to log in'.tr,
                              size: 14,
                              color: backgroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(policyUrl))) {
      throw Exception('Could not launch $policyUrl');
    }
  }
}

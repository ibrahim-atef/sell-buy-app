import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Routes/routes.dart';
import 'package:sell_buy/Utilities/icons.dart';
import 'package:sell_buy/View/Widgets/utilities_widgets/text_Component.dart';
import 'package:sell_buy/Controllers/auth_controller.dart';
import 'package:sell_buy/Utilities/my_strings.dart';
import 'package:sell_buy/Utilities/themes.dart';
import '../../Widgets/utilities_widgets/custom_text_from_field.dart';
import '../../Widgets/utilities_widgets/button_component.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
            IconBroken.Close_Square,
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
                            text: 'Log in to post an ad'.tr,
                            size: 24,
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
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
                          obscureText:
                              !authController.isVisibility ? true : false,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your password'.tr;
                            if (!RegExp(passwordPattern).hasMatch(value))
                              return 'The password must be at least 8 characters long and contain one letter and one number'
                                  .tr;
                            return null;
                          },
                          hintText: 'password'.tr,
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
                                      : Icon(IconBroken.Hide,
                                          color: mainColor.withOpacity(.5)),
                                ],
                              )),
                        );
                      }),
                      SizedBox(height: 20),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * .06),
                        child: GetBuilder<AuthController>(
                          builder: (_) {
                            return ButtonComponent(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // Proceed with login logic
                                  authController.loginUserWithEmail(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                }
                              },
                              text: authController.isLoginLoading.value
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * .2),
                                      child: LinearProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'sign in'.tr,
                                      style: TextStyle(
                                        color: white,
                                        fontFamily: 'Rubik',
                                      ),
                                    ),
                              width: double.infinity,
                            );
                          },
                        ),
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
}

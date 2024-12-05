
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/auth_controller.dart';
import '../../../Utilities/my_strings.dart';
import '../../../Utilities/themes.dart';
import '../../Widgets/utilities_widgets/button_component.dart';
import '../../Widgets/utilities_widgets/custom_text_from_field.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  SizedBox(height: Get.height * .1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget Password?".tr,
                        style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 18,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CustomTextFromField(
                    controller: emailController,
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your email'.tr;
                      if (!RegExp(emailPattern).hasMatch(value))
                        return 'Please enter a valid email address'.tr;
                      return null;
                    },
                    hintText: 'E-mail'.tr,
                    textInputType: TextInputType.text,
                    prefixIcon: SizedBox.shrink(),
                    suffixIcon: SizedBox.shrink(),
                  ),
                  SizedBox(height: Get.height * .1),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * .06),
                      child: GetBuilder<AuthController>(
                        builder: (_) {
                          return ButtonComponent(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await authController.resetPasswordByEmail(
                                  emailController.text.trim(),
                                );
                              }
                            },
                            text: authController.isResetPass.value
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: LinearProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Reset'.tr,
                                    style: TextStyle(
                                      color: white,
                                      fontFamily: 'Amiri',
                                    ),
                                  ),
                            width: double.infinity,
                          );
                        },
                      )),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

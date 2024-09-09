// import 'dart:async';
//
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mydoctor/controller/controllers/auth_controller.dart';
// import 'package:mydoctor/routes/routes.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// class PinCodeVerificationScreen extends StatefulWidget {
//   PinCodeVerificationScreen({
//     Key? key,
//   }) : super(key: key);
//
//   String name = Get.arguments[0];
//   String email = Get.arguments[1];
//   String password = Get.arguments[2];
//   String phoneNumber = Get.arguments[3];
//   bool isResetPassword = Get.arguments[4]??false;
//
//   @override
//   State<PinCodeVerificationScreen> createState() =>
//       _PinCodeVerificationScreenState();
// }
//
// class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
//   TextEditingController textEditingController = TextEditingController();
//
//   // ..text = "123456";
//
//   // ignore: close_sinks
//   StreamController<ErrorAnimationType>? errorController;
//
//
//   String currentText = "";
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     errorController = StreamController<ErrorAnimationType>();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     errorController!.close();
//
//     super.dispose();
//   }
//
//   // snackBar Widget
//   snackBar(String? message) {
//     return ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message!),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//
//   String name = Get.arguments[0];
//   String email = Get.arguments[1];
//   String password = Get.arguments[2];
//   String phoneNumber = Get.arguments[3];
//   final authController = Get.put(AuthController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: GestureDetector(
//         onTap: () {},
//         child: GetX<AuthController>(
//           builder: (_) {
//             return Directionality(
//               textDirection: TextDirection.ltr,
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: ListView(
//                   children: <Widget>[
//                     const SizedBox(height: 30),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height / 3,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(30),
//                         child: Icon(
//                           Icons.phone,
//                           size: 35,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 8.0),
//                       child: Text(
//                         'Phone Number Verification',
//                         style:
//                             TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 30.0, vertical: 8),
//                       child: RichText(
//                         text: TextSpan(
//                           text: "Enter the code sent to ",
//                           children: [
//                             TextSpan(
//                               text: "${widget.phoneNumber}",
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ],
//                           style: const TextStyle(
//                             color: Colors.black54,
//                             fontSize: 15,
//                           ),
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Form(
//                       key: formKey,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8.0,
//                           horizontal: 30,
//                         ),
//                         child: PinCodeTextField(
//                           appContext: context,
//                           pastedTextStyle: TextStyle(
//                             color: Colors.green.shade600,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           length: 6,
//                           obscureText: false,
//                           obscuringCharacter: '*',
//
//                           blinkWhenObscuring: true,
//                           animationType: AnimationType.fade,
//                           validator: (v) {
//                             if (v!.length < 3) {
//                               return "Enter valid number";
//                             } else {
//                               return null;
//                             }
//                           },
//                           pinTheme: PinTheme(
//                             shape: PinCodeFieldShape.box,
//                             borderRadius: BorderRadius.circular(5),
//                             fieldHeight: 50,
//                             fieldWidth: 40,
//                             activeFillColor: Colors.white,
//                           ),
//                           cursorColor: Colors.black,
//                           animationDuration: const Duration(milliseconds: 300),
//                           enableActiveFill: true,
//                           errorAnimationController: errorController,
//                           controller: textEditingController,
//                           keyboardType: TextInputType.number,
//                           boxShadows: const [
//                             BoxShadow(
//                               offset: Offset(0, 1),
//                               color: Colors.black12,
//                               blurRadius: 10,
//                             )
//                           ],
//                           onCompleted: (v) {
//                             debugPrint("Completed");
//                           },
//                           // onTap: () {
//                           //   print("Pressed");
//                           // },
//                           onChanged: (value) {
//                             debugPrint(value);
//                             setState(() {
//                               currentText = value;
//                             });
//                           },
//                           beforeTextPaste: (text) {
//                             debugPrint("Allowing to paste $text");
//                             //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                             //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                             return true;
//                           },
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                       child: Text(
//                      authController.hasError.value ? "*Please fill up all the cells properly" : "",
//                         style: const TextStyle(
//                           color: Colors.red,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Didn't receive the code? ",
//                           style: TextStyle(color: Colors.black54, fontSize: 15),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             authController.registerWithPhoneNumber(
//                               name: name,
//                               email: email,
//                               password: password,
//                               phoneNumber: phoneNumber,
//                             );
//                           },
//                           child: const Text(
//                             "RESEND",
//                             style: TextStyle(
//                               color: Color(0xFF91D3B3),
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 14,
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 16.0, horizontal: 30),
//                       decoration: BoxDecoration(
//                           color: Colors.green.shade300,
//                           borderRadius: BorderRadius.circular(5),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.green.shade200,
//                                 offset: const Offset(1, -2),
//                                 blurRadius: 5),
//                             BoxShadow(
//                                 color: Colors.green.shade200,
//                                 offset: const Offset(-1, 2),
//                                 blurRadius: 5)
//                           ]),
//                       child: ButtonTheme(
//                         height: 50,
//                         child: TextButton(
//                           onPressed: () {
//                             formKey.currentState!.validate();
//                             // conditions for validating
//                             if (currentText.length != 6||authController.hasError.value) {
//                               errorController!.add(ErrorAnimationType
//                                   .shake); // Triggering error shake animation
//
//                             } else {
//                               setState(
//                                 () {
//                                   authController.hasError.value = false;
//                                widget.isResetPassword?authController.checkVerificationCodeForResetPass(
//                                    currentText, phoneNumber):   authController.checkVerificationCode(
//                                       currentText,
//                                       name,
//                                       email,
//                                       password,
//                                       phoneNumber);
//                                   // snackBar("OTP Verified!!");
//                                 },
//                               );
//                             }
//                           },
//                           child: Center(
//                             child: authController.isCheckingPin.value
//                                 ? CircularProgressIndicator(
//                                     color: Colors.white,
//                                   )
//                                 : Text(
//                                     "VERIFY".toUpperCase(),
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Flexible(
//                           child: TextButton(
//                             child: const Text("Clear"),
//                             onPressed: () {
//                               authController.hasError.value=false;
//                               textEditingController.clear();
//                             },
//                           ),
//                         ),
//
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

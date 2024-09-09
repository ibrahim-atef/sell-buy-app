// import 'package:eilaj/controller/controllers/health_institution_controller.dart';
// import 'package:eilaj/controller/controllers/user_controller.dart';
// import 'package:eilaj/routes/routes.dart';
// import 'package:eilaj/utilities/my_strings.dart';
// import 'package:eilaj/view/widgets/utilities_widgets/app_logo.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     final authValue = GetStorage().read(KRole);
//     if (authValue == null) {
//
//     } else if (authValue == usersCollectionKey) {
//       Get.put(UserController());
//     } else if (authValue == healthInstitutionCollectionKey) {
//       Get.put(HealthInstitutionController());
//     } else {
//
//     }
//     Future.delayed(Duration(seconds: 3), () {
//
//       if (authValue == null) {
//         Get.offNamed(Routes.loginScreen);
//       } else if (authValue == usersCollectionKey) {
//         Get.offNamed(Routes.patientsListScreen);
//       } else if (authValue == healthInstitutionCollectionKey) {
//         Get.offNamed(Routes.homeHealthInstitutionScreen);
//       } else {
//         Get.offNamed(Routes.loginScreen);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Color(0xff157686),
//       body: Center(
//         child: Image.asset("assets/app_icon/splashIcon.jpg",scale: 2,),
//       ),
//     );
//   }
// }

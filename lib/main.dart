import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sell_buy/Model/categories_subcategories_model.dart';
import 'package:sell_buy/routes/routes.dart';
import 'package:sell_buy/utilities/my_strings.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_buy/utilities/themes.dart';
import 'language/localiztion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(GetStorage().read<String>('lang') ?? ara),
      translations: LocaliztionApp(),
      fallbackLocale: Locale(ara),
      title: 'بيع واشتر',
      theme: ThemeData(
        backgroundColor: white,
        useMaterial3: true,
      ),
      initialRoute: Routes.SplashScreen,
      getPages: AppRoutes.routes,
    );
  }
}

/*
---> total hours on this project : 5 +5 +5 + 4 + 4
 */

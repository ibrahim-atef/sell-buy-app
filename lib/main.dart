import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sell_buy/routes/routes.dart';
import 'package:sell_buy/utilities/my_strings.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_buy/utilities/themes.dart';
import 'Model/categories_subcategories_model.dart';
import 'language/localiztion.dart';


List<LastSubcategory> newCarsLastSubcategories = [
  LastSubcategory(
    id: "nissan",
    name: "Nissan",
    arName: "نيسان جديد",
    imagePath: "path/to/nissan_logo.png", // Replace with actual image URL if available
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "ford",
    name: "Ford",
    arName: "فورد جديد",
    imagePath: "path/to/ford_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "bmw",
    name: "BMW",
    arName: "بي ام دبليو جديد",
    imagePath: "path/to/bmw_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "mercedes",
    name: "Mercedes",
    arName: "مرسيدس جديد",
    imagePath: "path/to/mercedes_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "mitsubishi",
    name: "Mitsubishi",
    arName: "ميتسوبيشي جديد",
    imagePath: "path/to/mitsubishi_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "gmc",
    name: "GMC",
    arName: "جي إم سي جديد",
    imagePath: "path/to/gmc_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "chevrolet",
    name: "Chevrolet",
    arName: "شيفرولية جديد",
    imagePath: "path/to/chevrolet_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "lexus",
    name: "Lexus",
    arName: "لكزس جديد",
    imagePath: "path/to/lexus_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "lincoln",
    name: "Lincoln",
    arName: "لينكون جديد",
    imagePath: "path/to/lincoln_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "porsche",
    name: "Porsche",
    arName: "بورش جديد",
    imagePath: "path/to/porsche_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "audi",
    name: "Audi",
    arName: "أودي جديد",
    imagePath: "path/to/audi_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "honda",
    name: "Honda",
    arName: "هوندا جديد",
    imagePath: "path/to/honda_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "land_rover",
    name: "Land Rover",
    arName: "لاند روفر جديد",
    imagePath: "path/to/land_rover_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "jaguar",
    name: "Jaguar",
    arName: "جاجوار جديد",
    imagePath: "path/to/jaguar_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "cadillac",
    name: "Cadillac",
    arName: "كاديلاك جديد",
    imagePath: "path/to/cadillac_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "chrysler",
    name: "Chrysler",
    arName: "كرايسلر جديد",
    imagePath: "path/to/chrysler_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "hyundai",
    name: "Hyundai",
    arName: "هيونداي جديد",
    imagePath: "path/to/hyundai_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
  LastSubcategory(
    id: "kia",
    name: "Kia",
    arName: "كيا جديد",
    imagePath: "path/to/kia_logo.png",
    categoryId: "vehicles",
    subcategoryId: "New Cars",
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
  ),
];
Future<void> uploadSubcategories( ) async {
  final collection = FirebaseFirestore.instance
      .collection('categories')
      .doc("vehicles")
      .collection("subcategories")
      .doc("New Cars")
      .collection("subcategories");

  for (var subcategory in newCarsLastSubcategories) {
    collection.doc(subcategory.id).set(subcategory.toMap());
  }

}

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
      title: 'Sell Buy',
      theme: ThemeData(
        // backgroundColor: white,
        useMaterial3: true,
      ),
      initialRoute: Routes.SplashScreen,
      getPages: AppRoutes.routes,
    );
  }
}

/*
---> total hours on this project : 5 +5 +5 + 4 + 4+1
com.businessThamer.sellBuy
 */

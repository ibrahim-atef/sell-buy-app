import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_buy/Model/ad_model.dart';

import '../Routes/routes.dart';
import '../Services/firestore_methods.dart';
import '../Utilities/my_strings.dart';

class AdServicesController extends GetxController {
  final GetStorage storageBox = GetStorage();
  late String userId = "";
  List<AdModel> favouriteAds = [];

  @override
  void onInit() {
    initUser();
    super.onInit();
  }

  initUser() async {
    userId = storageBox.read(KUid) ?? "";
    getFavouriteAds();
  }

  /// Receive a time stamp and return how much time passed in minutes, hours or days
  String timePassed(int timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final diff = now - timestamp;

    final minutes = diff ~/ (1000 * 60);
    final hours = minutes ~/ 60;
    final days = hours ~/ 24;
    final months = days ~/ 30; // Approximation of a month (30 days)
    final years = days ~/ 365; // Approximation of a year (365 days)

    if (years > 0) {
      return '${years} ' + 'y'.tr; // Translate 'y' for year
    } else if (months > 0) {
      return '${months} ' + 'mo'.tr; // Translate 'mo' for months
    } else if (days > 0) {
      return '${days} ' + 'd'.tr; // Translate 'd' for days
    } else if (hours > 0) {
      return '${hours} ' + 'h'.tr; // Translate 'h' for hours
    } else {
      return '${minutes} ' + 'm'.tr; // Translate 'm' for minutes
    }
  }

  void addViewToAd({
    required String adId,
    required String userId,
    required String categoryCollection,
  }) async {
    String tempId = await storageBox.read(KUid) ?? "";
    if (tempId == null || tempId.isEmpty) {
      favouriteAds.clear();
      update();
      return;
    }
    try {
      await FireStoreMethods.addViewToAd(
          adId: adId, uid: userId, categoryCollection: categoryCollection);
    } catch (e) {
      print("Error adding view to ad: $e");
    }
  }

  Future<int> getViewsCount(
      {required String adId, required String categoryCollection}) async {
    try {
      int? snapshot = await FireStoreMethods.getViewsCount(
          adId: adId, categoryCollection: categoryCollection);
      return snapshot ?? 0;
    } catch (error) {
      print("Error getting views count: $error");
      throw Exception("Failed to get views count");
    }
  }

  /// Add ad to Favourites
  RxBool isAddingToFavourites = false.obs;

  void addAdToFavourites(
      {required AdModel adModel, required String userId}) async {
    String tempId = await storageBox.read(KUid) ?? "";
    if (tempId == null || tempId.isEmpty) {
      favouriteAds.clear();
      update();
      Get.toNamed(Routes.LoginScreen);
      return;
    }
    try {
      isAddingToFavourites.value = true;
      await FireStoreMethods.addAdToFavourites(
          favoriteItem: adModel, uid: tempId);
    } catch (e) {
      isAddingToFavourites.value = false;
      print("Error adding ad to favourites: $e");
    } finally {
      isAddingToFavourites.value = false;
      update();
    }
  }

  /// Remove ad from Favourites
  void removeAdFromFavourites(
      {required String adId, required String userId}) async {
    String tempId = await storageBox.read(KUid) ?? "";
    if (tempId == null || tempId.isEmpty) {
      favouriteAds.clear();
      update();
      return;
    }
    try {
      await FireStoreMethods.removeAdFromFavourites(uid: tempId, adId: adId);
    } catch (e) {
      print("Error removing ad from favourites: $e");
    } finally {
      update();
    }
  }

  /// get user favourite ads
  getFavouriteAds() async {
    String tempId = await storageBox.read(KUid) ?? "";
    if (tempId == null || tempId.isEmpty) {
      favouriteAds.clear();
      update();
      return;
    }
    FireStoreMethods.usersCollection
        .doc(userId)
        .collection(favoritesCollectionKey)
        .snapshots()
        .listen((event) {
      favouriteAds.clear();
      for (var doc in event.docs) {
        favouriteAds.add(AdModel.fromJson(doc.data()));
      }
      update();
    });
  }

  /// function to check if ad is favourite
  bool isAdFavourite(String adId) {
    return favouriteAds.any((element) => element.id == adId);
  }
}
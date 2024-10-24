import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_buy/Model/ad_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Routes/routes.dart';
import '../Services/firestore_methods.dart';
import '../Utilities/my_strings.dart';

class AdServicesController extends GetxController {
  final GetStorage storageBox = GetStorage();
  late String userId = "";
  List<AdModel> favouriteAds = [];
  List<AdModel> recentlyViewedAds = [];

  @override
  void onInit() {
    initUser();
    super.onInit();
  }

  initUser() async {
    userId = storageBox.read(KUid) ?? "";
    getFavouriteAds();
    getRecentlyViewedAds();
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
    required String adCollectionType,
  }) async {
    String tempId = await storageBox.read(KUid) ?? "";
    if (tempId == null || tempId.isEmpty) {
      favouriteAds.clear();
      update();
      return;
    }
    try {
      await FireStoreMethods.addViewToAd(
          adId: adId,
          uid: userId,
          categoryCollection: categoryCollection,
          adCollectionType: adCollectionType);
    } catch (e) {
      print("Error adding view to ad: $e");
    }
  }

  int viewsCount = 0;

  void clearViewsCount() {
    viewsCount = 0;
    update();
  }

  updateViewsCount({
    required String adId,
    required String categoryCollection,
    required String adCollectionType,
  }) async {
    viewsCount = await getViewsCount(
            adId: adId,
            categoryCollection: categoryCollection,
            adCollectionType: adCollectionType) ??
        0;
    update();
  }

  Future<int> getViewsCount({
    required String adId,
    required String categoryCollection,
    required String adCollectionType,
  }) async {
    try {
      int? snapshot = await FireStoreMethods.getViewsCount(
          adId: adId,
          categoryCollection: categoryCollection,
          adCollectionType: adCollectionType);
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

  /// add to recently viewed
  void addAdToRecentlyViewed({required AdModel adModel}) async {
    String tempId = await storageBox.read(KUid) ?? "";
    if (tempId == null || tempId.isEmpty) {
      recentlyViewedAds.clear();
      update();
      return;
    }
    try {
      await FireStoreMethods.addAdToRecentlyViewed(
          uid: tempId, recentlyViewedItem: adModel);
    } catch (e) {
      print("Error adding ad to recently viewed: $e");
    } finally {
      update();
    }
  }

  /// get user recently viewed ads
  RxBool isGettingRecentlyViewed = false.obs;

  getRecentlyViewedAds() async {
    isGettingRecentlyViewed.value = true;
    String tempId = await storageBox.read(KUid) ?? "";
    if (tempId == null || tempId.isEmpty) {
      recentlyViewedAds.clear();
      isGettingRecentlyViewed.value = false;
      update();
      return;
    }

    try {
      final event = await FireStoreMethods.usersCollection
          .doc(tempId)
          .collection(recentlyViewedCollectionKey)
          .get();

      recentlyViewedAds.clear();
      for (var doc in event.docs) {
        recentlyViewedAds.add(AdModel.fromJson(doc.data()));
      }
    } catch (e) {
      print("Error getting recently viewed ads: $e");
    } finally {
      isGettingRecentlyViewed.value = false;
      update();
    }
  }

  /// get user favourite ads
  RxBool isGettingFavouritesAds = false.obs;

  getFavouriteAds() async {
    isGettingFavouritesAds.value = true;
    String tempId = await storageBox.read(KUid) ?? "";
    if (tempId == null || tempId.isEmpty) {
      favouriteAds.clear();
      isGettingFavouritesAds.value = false;
      update();
      return;
    }

    try {
      final event = await FireStoreMethods.usersCollection
          .doc(tempId)
          .collection(favoritesCollectionKey)
          .get(); // get favourites collection

      favouriteAds.clear();
      for (var doc in event.docs) {
        favouriteAds.add(AdModel.fromJson(doc.data()));
      }
    } catch (e) {
      print("Error getting favourites ads: $e");
    } finally {
      isGettingFavouritesAds.value = false;
      update();
    }
  }

  /// function to check if ad is favourite
  bool isAdFavourite(String adId) {
    return favouriteAds.any((element) => element.id == adId);
  }

  Future<void> openWhatsApp(String phoneNumber) async {
    String whatsappUrl = "whatsapp://send?phone=$phoneNumber";
    String dialUrl = "tel:$phoneNumber";

    // Check if WhatsApp is installed
    await launch(whatsappUrl);
  }

  ///--------------------->>>>>>>>>>>>>>>>>>>>>>>>>>  flutter lunching call by url --------------------------------------

  Future<void> openCall(String phoneNumber) async {
    String dialUrl = "tel:$phoneNumber";
    await launch(dialUrl);
  }

  Future<void> downloadImage(String imageUrl) async {
    Get.snackbar("Error", "Failed to download image");
  }
}

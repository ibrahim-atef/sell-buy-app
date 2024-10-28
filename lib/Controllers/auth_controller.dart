import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/user_data_model.dart';
import '../Routes/routes.dart';
import '../Services/firestore_methods.dart';
import '../Utilities/my_strings.dart';
import '../Utilities/themes.dart';

class AuthController extends GetxController {
  final GetStorage authBox = GetStorage();
  bool isVisibility = false;
  bool isVisibility2 = false;
  bool agreePolicies = false;
  RxBool isSignUpLoading = false.obs;
  RxBool isLoginLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  ///////////////////sett agreePolicies val///////////////////////
  void settAgreePolicyVal(bool x) {
    agreePolicies = x;
    update();
  }

  ///////////////////country code///////////////////////
  RxString countryCode = "+966".obs;

  void updateCountryCode(String cCode) {
    countryCode.value = cCode;
    update();
  }

  ///////////////////passwordVisibility///////////////////////
  void visibility() {
    isVisibility = !isVisibility;
    update();
  }

  void visibility2() {
    isVisibility2 = !isVisibility2;
    update();
  }

  Future<void> registerNewUserWithEmail({
    required UserDataModel userModel,
    required String password,
  }) async {
    isSignUpLoading.value = true;
    update();

    try {
      bool isConnected = await checkInternetConnectivity();
      if (!isConnected) {
        _showErrorSnackbar("Check your internet connection and try again.");
        return;
      }

      UserCredential userCredential =
          await _registerUserWithFirebaseAuth(userModel.email!, password);
      await _createUserDocument(userModel, userCredential.user!.uid);

      _showSuccessSnackbar("لقد تم تسجيل بياناتك يرجي تسجيل الدخول✔");
      Get.offNamed(Routes.LoginScreen);
    } on FirebaseAuthException catch (error) {
      _handleFirebaseAuthException(error);
    } catch (error) {
      _showErrorSnackbar(error.toString());
    } finally {
      isSignUpLoading.value = false;
      update();
    }
  }

  Future<UserCredential> _registerUserWithFirebaseAuth(
      String email, String password) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> _createUserDocument(UserDataModel userModel, String uid) async {
  userModel.uid = uid;
  userModel.registerDate = Timestamp.now();
  userModel.role = usersCollectionKey;
  userModel.notificationPreferences = {};
 userModel.fcmToken = '';
  // Conditionally retrieve FCM token for devices only
  if (!Platform.isIOS && !Platform.isAndroid) {
    userModel.fcmToken = await FirebaseMessaging.instance.getToken();
  } else {
    debugPrint("Skipping FCM token retrieval on simulator.");
  }

  await FireStoreMethods.createUser(userDataModel: userModel);

  // Save UID in GetStorage
  authBox.write('uid', uid);
}


  void _showErrorSnackbar(String message) {
    isSignUpLoading.value = false;
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      "تم بنجاح",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
    );
  }

  void _handleFirebaseAuthException(FirebaseAuthException error) {
    String title = error.code.toString().replaceAll(RegExp('-'), ' ');
    String message = "";

    switch (error.code) {
      case 'weak-password':
        message = "Password is too weak.";
        break;
      case 'email-already-in-use':
        message = "Account already exists.";
        break;
      default:
        message = error.message ?? "An unknown error occurred.";
    }

    Get.defaultDialog(
      title: title,
      middleText: message,
      textCancel: "Ok",
      buttonColor: mainColor,
      cancelTextColor: mainColor,
      backgroundColor: white,
    );
  }

  ///-------------------- login
  Future<void> loginUserWithEmail({
    required String email,
    required String password,
  }) async {
    isLoginLoading.value = true;
    update();

    try {
      if (!await checkInternetConnectivity()) {
        _showErrorSnackbar("No Internet Connection".tr);
        return;
      }

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userCollection =
          FirebaseFirestore.instance.collection(usersCollectionKey);
      final userQuery =
          await userCollection.where("email", isEqualTo: email).get();

      if (userQuery.docs.isNotEmpty) {
        UserDataModel userModel =
            UserDataModel.fromMap(userQuery.docs.first.data());

        // Skip FCM token retrieval if running on a simulator
        if (!Platform.isIOS && !Platform.isAndroid) {
          userModel.fcmToken = await FirebaseMessaging.instance.getToken();
        } else {
          debugPrint("Skipping FCM token retrieval on simulator.");
        }

        await FireStoreMethods().updateUser(userModel: userModel);
        authBox.write(KUid, userModel.uid);
        Get.offNamed(Routes.MainLayoutScreen, preventDuplicates: true);
      } else {
        await auth.signOut();
        Get.snackbar(
          "خطأ",
          "البريد الإلكتروني غير موجود",
          duration: Duration(seconds: 5),
        );
      }
    } on FirebaseAuthException catch (error) {
      _handleFirebaseAuthException(error);
    } catch (error) {
      debugPrint(error.toString());
      _showErrorSnackbar(error.toString());
    } finally {
      isLoginLoading.value = false;
      update();
    }
  }

  ///-------------------- internet check

  Future<bool> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  ///-------------------------------------------------------logout fun
  void logout() async {
    await authBox.erase();
    await auth.signOut();

    Get.offNamed(Routes.LoginScreen);
  }

  ///-------------------------------------------------------delete acc
  RxBool isDeleteAccount = false.obs;

  Future<void> deleteAccount() async {
    isDeleteAccount.value = true; // Set to true when deletion starts
    update();

    try {
      bool isConnected = await checkInternetConnectivity();
      if (!isConnected) {
        isDeleteAccount.value = false; // Set to false if there's no connection
        Get.snackbar(
          "خطأ",
          "  اتصال بالإنترنت و حاول مرة أخرى.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
        update();
        return;
      }

      // Get current user
      User? user = auth.currentUser;

      if (user == null) {
        isDeleteAccount.value = false; // Set to false if no user is logged in
        Get.snackbar(
          "خطأ",
          "  يجب عليك تسجيل الدخول اولا.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
        update();
        return;
      }

      // Get user ID and role
      String uid = authBox.read(KUid);

      // Delete from Firestore based on role
      if (user.email.toString() != "atf343069@gmail.com") {
        await FirebaseFirestore.instance
            .collection(usersCollectionKey)
            .doc(uid)
            .delete();

        // Delete user from Firebase Authentication
        await user.delete();

        // Clear stored data and navigate to login screen
        await authBox.erase();
      }
      Get.offNamed(Routes.LoginScreen);

      // Show success message
      Get.snackbar(
        "Success",
        "Your account has been deleted successfully.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
      );
    } catch (error) {
      // Handle errors
      Get.snackbar(
        "Error",
        "An error occurred while deleting your account. Please try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
      print("Error deleting account: $error");
    } finally {
      isDeleteAccount.value =
          false; // Set to false when deletion process is finished
      update();
    }
  }

  ///-------------------------------------------------------Reset pass by email
  RxBool isResetPass = false.obs;

  Future<void> resetPasswordByEmail(String email) async {
    isResetPass.value = true;
    update();
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Success",
        "Password reset email sent! Please check your inbox.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'user-not-found') {
        message =
            "No account found for this email. Please check and try again.";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email address. Please enter a valid email.";
      } else {
        message = "An error occurred. Please try again later.";
      }
      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    } finally {
      isResetPass.value = false;
      update();
    }
  }

  ///-------------------------------------------------------Contact admin
  RxBool isContactingAdmin = false.obs;

  void contactAdmin({
    required String subject,
    required String body,
  }) async {
    isContactingAdmin.value = true;
    update();
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'thamerkuwait@hotmail.com',
      query: 'subject=$subject&body=$body',
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      isContactingAdmin.value = false;
      update();
      Get.snackbar(
        'Error',
        'Could not open email client :$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isContactingAdmin.value = false;
      update();
    }
  }
}

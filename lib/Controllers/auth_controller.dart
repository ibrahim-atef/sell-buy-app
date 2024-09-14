import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
    userModel.fcmToken = await FirebaseMessaging.instance.getToken();
    userModel.notificationPreferences = {};

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
      bool isConnected = await checkInternetConnectivity();
      if (!isConnected) {
        _showErrorSnackbar("No Internet Connection".tr);
        return;
      }

      await auth.signInWithEmailAndPassword(email: email, password: password);

      _showSuccessSnackbar("Login successful!");
      Get.offNamed(Routes.MainLayoutScreen);
    } on FirebaseAuthException catch (error) {
      _handleFirebaseAuthException(error);
    } catch (error) {
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
}

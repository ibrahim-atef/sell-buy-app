import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final GetStorage authBox = GetStorage();
  bool isVisibility = false;
  bool isVisibility2 = false;
  bool agreePolicies = false;
  RxBool isSignUpLoading = false.obs;
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


}

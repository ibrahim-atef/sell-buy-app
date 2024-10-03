import 'dart:io';
import 'package:get/get.dart';

class InternetController extends GetxController {
  RxBool isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnection(); // Initial check when controller is initialized
  }

  /// Check the internet connection and update the RxBool
  Future<void> checkConnection() async {
    isConnected.value = await _checkInternet();
    update(); // Notify listeners about the change
  }

  /// Check if the device is connected to the internet
  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  /// Call this method to manually trigger a connection check
  void updateConnectionStatus() {
    checkConnection();
  }

/// Optionally, you could periodically check the connection
/// using a Timer, or integrate a listener for changes in network connectivity.
}

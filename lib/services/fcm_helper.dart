import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FcmHandler {
  static String accessToken = '';


  static Future<void> initializeAccessToken() async {
    final serviceAccountJson = await rootBundle.loadString(
        'assets/eilaj-cab49-firebase-adminsdk-705uy-7fa294cd74.json');

    final accountCredentials = ServiceAccountCredentials.fromJson(
      json.decode(serviceAccountJson),
    );

    const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = http.Client();
    try {
      final accessCredentials = await obtainAccessCredentialsViaServiceAccount(
        accountCredentials,
        scopes,
        client,
      );

      accessToken = accessCredentials.accessToken.data;
      print('Access Token: $accessToken');
    } catch (e) {
      print('Error obtaining access token: $e');
    } finally {
      client.close();
    }
  }

  static Future<void> sendNotificationToAllDevices(
      String title, String body) async {
    await _sendNotification(
      title: title,
      body: body,
      to: "allDevices",
    );
  }


  static Future<void> sendNotificationToUser(
      String token, String title, String body, Map<String, dynamic> sentData) async {
    Map<String, dynamic> data = {
      "message": {
        "token": token,
        "notification": {
          "title": title,
          "body": body,
        },
        "data": sentData,
        "android": {
          "priority": "high"
        },
        "apns": {
          "payload": {
            "aps": {
              "sound": "default",
              "badge": 1
            }
          }
        }
      }
    };

    await _sendNotificationData(data);
  }

  static Future<void> sendNotificationToInstitution(
      String token, String title, String body) async {
    Map<String, dynamic> data = {
      "message": {
        "token": token,
        "notification": {
          "title": title,
          "body": body,
        },
        "data": {}
      }
    };
    await _sendNotificationData(data);
  }

  static Future<void> sendNotificationToAllHealthInstitutions(
      String title, String body) async {
    await _sendNotification(
      title: title,
      body: body,
      to: "allHealthInstitutions",
    );
  }

  static Future<void> sendNotificationToAllUsers(
      String title, String body) async {
    await _sendNotification(
      title: title,
      body: body,
      to: "allUsers",
    );
  }

  static Future<void> _sendNotification(
      {required String title, required String body, required String to,}) async {
    Map<String, dynamic> notificationData = {
      "message": {
        "topic": to,
        "notification": {
          "title": title,
          "body": body,
        },
        "data": {}
      }
    };
    await _sendNotificationData(notificationData);
  }

  static Future<void> _sendNotificationData(Map<String, dynamic> data) async {
    var bodyData = json.encode(data);

    try {
      var response = await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/eilaj-cab49/messages:send'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: bodyData,
      );

      print("FCM Response Status Code: ${response.statusCode}");
      print("FCM Response Body: ${response.body}");
    } catch (e) {
      print("Error sending FCM notification: $e");
    }
  }
}

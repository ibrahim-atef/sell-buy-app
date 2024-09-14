import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String? userName;
  String? email;
  String? phoneNumber;
  Timestamp? registerDate;
  String? uid;
  String? role;
  String? fcmToken;
  bool isActivated;
  Map<String, bool>? notificationPreferences;

  UserDataModel({
    this.userName,
    this.uid,
    this.email,
    required this.isActivated,
    this.phoneNumber,
    this.registerDate,
    this.role,
    this.fcmToken,
    this.notificationPreferences,
  });

  factory UserDataModel.fromMap(map) {
    return UserDataModel(
      userName: map['userName'],
      uid: map['uid'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      registerDate: map['registerDate'],
      role: map['role'],
      fcmToken: map['fcmToken'],
      isActivated: map['isActivated'],
      notificationPreferences:
          Map<String, bool>.from(map['notificationPreferences'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'registerDate': registerDate,
      'uid': uid,
      'role': role,
      'fcmToken': fcmToken,
      'isActivated': isActivated,
      'notificationPreferences': notificationPreferences
    };
  }
}

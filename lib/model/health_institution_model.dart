import 'package:cloud_firestore/cloud_firestore.dart';

class HealthInstitutionModel {
  String? userName;
  String? email;
  String? phoneNumber;
  Timestamp? registerDate;
  String? uid;
  String?
      role; // Added role to distinguish user types  'user', 'admin', 'health_institution'
  String? address;
  String? civilNumber;
  String? fcmToken;
  bool isActivated;

  HealthInstitutionModel({
    this.userName,
    this.uid,
    this.email,
    this.phoneNumber,
    this.registerDate,
    this.role,
    this.address,
    this.civilNumber,
    this.fcmToken,
  required this.isActivated
  });

  factory HealthInstitutionModel.fromMap(map) {
    return HealthInstitutionModel(
      userName: map['userName'],
      uid: map['uid'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      registerDate: map['registerDate'],
      role: map['role'],
      address: map['address'],
      civilNumber: map['civilNumber'],
      fcmToken: map['fcmToken'],
      isActivated: map['isActivated'],
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
      'address': address,
      'civilNumber': civilNumber,
      'fcmToken': fcmToken,
      'isActivated': isActivated,
    };
  }
}

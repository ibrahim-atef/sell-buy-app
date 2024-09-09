import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userName;
  String? email;
  String? civilNumber;
  String? phoneNumber;
  Timestamp? registerDate;
  String? birthDate;
  String? uid;
  String?
      role; // Added role to distinguish user types  'user', 'admin', 'health_institution'
  String? address;
  String? fcmToken;
  bool isActivated;

  UserModel(
      {this.userName,
      this.uid,
      this.email,
      this.civilNumber,
      required this.birthDate,
      required this.isActivated,
      this.phoneNumber,
      this.registerDate,
      this.role,
      this.address,
      this.fcmToken});

  factory UserModel.fromMap(map) {
    return UserModel(
      userName: map['userName'],
      uid: map['uid'],
      email: map['email'],
      civilNumber: map['civilNumber'],
      phoneNumber: map['phoneNumber'],
      registerDate: map['registerDate'],
      role: map['role'],
      address: map['address'],
      fcmToken: map['fcmToken'],
      birthDate: map['birthDate'],
      isActivated: map['isActivated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'civilNumber': civilNumber,
      'phoneNumber': phoneNumber,
      'registerDate': registerDate,
      'uid': uid,
      'role': role,
      'birthDate': birthDate,
      'fcmToken': fcmToken,
      'address': address,
      'isActivated': isActivated
    };
  }
}

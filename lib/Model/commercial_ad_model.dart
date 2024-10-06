import 'package:cloud_firestore/cloud_firestore.dart';

class CommercialAdModel {
  String id;
  String imagePath;
  String ownerName;
  String ownerID;
  String ownerPhoneNum;
  String ownerWhatsappNum;
  String category;
  String categoryNameAr;
  String subCategory;
  String selectedSubcategoryArName;
  Timestamp createdAt;
  Timestamp updatedAt;
  bool isSuspended = false;

  CommercialAdModel({
    required this.id,
    required this.imagePath,
    required this.ownerName,
    required this.ownerID,
    required this.ownerPhoneNum,
    required this.category,
    required this.ownerWhatsappNum,
    required this.categoryNameAr,
    required this.subCategory,
    required this.selectedSubcategoryArName,
    required this.createdAt,
    required this.updatedAt,
    this.isSuspended = false,
  });

  factory CommercialAdModel.fromJson(json) {
    return CommercialAdModel(
      id: json['id'],
      imagePath: json['imagePath'],
      ownerName: json['ownerName'],
      ownerID: json['ownerID'],
      ownerPhoneNum: json['ownerPhoneNum'],
      category: json['category'],
      ownerWhatsappNum: json['ownerWhatsappNum'],
      categoryNameAr: json['categoryNameAr'],
      subCategory: json['subCategory'],
      selectedSubcategoryArName: json['selectedSubcategoryArName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isSuspended: json['isSuspended'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'ownerName': ownerName,
      'ownerID': ownerID,
      'ownerPhoneNum': ownerPhoneNum,
      'ownerWhatsappNum': ownerWhatsappNum,
      'category': category,
      'categoryNameAr': categoryNameAr,
      'subCategory': subCategory,
      'selectedSubcategoryArName': selectedSubcategoryArName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isSuspended': isSuspended,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sell_buy/Model/location_model.dart';

class CommercialAdModel {
  String id;
  String imagePath;
  String ownerName;
  String ownerID;
  String ownerPhoneNum;
  String ownerWhatsappNum;
  String category;
  String price;
  String categoryNameAr;
  String subCategory;
  String selectedSubcategoryArName;
  String thirdSubCategory;
  String thirdSubCategoryArName;
  Timestamp createdAt;
  Timestamp updatedAt;
  bool isSuspended = false;
  LocationModel? locationModel;

  CommercialAdModel({
    required this.id,
    required this.imagePath,
    required this.ownerName,
    required this.ownerID,
    required this.ownerPhoneNum,
    required this.category,
    required this.price,
    required this.ownerWhatsappNum,
    required this.categoryNameAr,
    required this.subCategory,
    required this.selectedSubcategoryArName,
    required this.thirdSubCategory,
    required this.thirdSubCategoryArName,
    required this.createdAt,
    required this.updatedAt,
    this.isSuspended = false,
    required this.locationModel,

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
      price: json['price'],
      selectedSubcategoryArName: json['selectedSubcategoryArName'],
      thirdSubCategory: json['thirdSubCategory'],
      thirdSubCategoryArName: json['thirdSubCategoryArName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isSuspended: json['isSuspended'] ?? false,
      locationModel: LocationModel.fromJson(json['locationModel']),

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
      'price': price,
      'categoryNameAr': categoryNameAr,
      'subCategory': subCategory,
      'selectedSubcategoryArName': selectedSubcategoryArName,
      'thirdSubCategory': thirdSubCategory,
      'thirdSubCategoryArName': thirdSubCategoryArName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isSuspended': isSuspended,
      'locationModel':   locationModel?.toJson(),

    };
  }
}

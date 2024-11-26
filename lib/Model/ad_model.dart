import 'package:cloud_firestore/cloud_firestore.dart';
import 'location_model.dart';

class AdModel {
  String id;
  String title;
  String description;
  String location;
  String imagePath;
  List<String> imageUrls;
  String price;
  String postedTime;
  String ownerName;
  String ownerID;
  String ownerPhoneNum;
  String ownerWhatsappNum;
  String category;
  String categoryNameAr;
  String subCategory;
  String selectedSubcategoryArName;
  String thirdSubCategory;
  String thirdSubCategoryArName;
  Timestamp createdAt;
  Timestamp updatedAt;
  bool isSuspended;
  LocationModel? locationModel;
  Map<String, dynamic>? adExtraDetails; // New field for additional details

  AdModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imagePath,
    required this.imageUrls,
    required this.price,
    required this.postedTime,
    required this.ownerName,
    required this.ownerID,
    required this.ownerPhoneNum,
    required this.category,
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
     this.adExtraDetails = const {}, // Initialize the new field
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      imagePath: json['imagePath'],
      imageUrls: List<String>.from(json['imageUrls']),
      price: json['price'],
      postedTime: json['postedTime'],
      ownerName: json['ownerName'],
      ownerID: json['ownerID'],
      ownerPhoneNum: json['ownerPhoneNum'],
      category: json['category'],
      ownerWhatsappNum: json['ownerWhatsappNum'],
      categoryNameAr: json['categoryNameAr'],
      subCategory: json['subCategory'],
      selectedSubcategoryArName: json['selectedSubcategoryArName'],
      thirdSubCategory: json['thirdSubCategory'],
      thirdSubCategoryArName: json['thirdSubCategoryArName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isSuspended: json['isSuspended'] ?? false,
      locationModel: json['locationModel'] != null
          ? LocationModel.fromJson(json['locationModel'])
          : null,
      adExtraDetails: json['adExtraDetails'] != null
          ? Map<String, dynamic>.from(json['adExtraDetails'])
          : null, // Deserialize the new field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'imagePath': imagePath,
      'imageUrls': imageUrls,
      'price': price,
      'postedTime': postedTime,
      'ownerName': ownerName,
      'ownerID': ownerID,
      'ownerPhoneNum': ownerPhoneNum,
      'ownerWhatsappNum': ownerWhatsappNum,
      'category': category,
      'categoryNameAr': categoryNameAr,
      'subCategory': subCategory,
      'selectedSubcategoryArName': selectedSubcategoryArName,
      'thirdSubCategory': thirdSubCategory,
      'thirdSubCategoryArName': thirdSubCategoryArName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isSuspended': isSuspended,
      'locationModel': locationModel?.toJson(),
      'adExtraDetails': adExtraDetails, // Serialize the new field
    };
  }
}

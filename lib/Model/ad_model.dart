import 'package:cloud_firestore/cloud_firestore.dart';

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
  String category;
  String categoryNameAr;
  String subCategory;
  String selectedSubcategoryArName;
  Timestamp createdAt;
  Timestamp updatedAt;
  bool isSuspended = false;

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
    required this.categoryNameAr,
    required this.subCategory,
    required this.selectedSubcategoryArName,
    required this.createdAt,
    required this.updatedAt,
    this.isSuspended = false,
  });


  factory AdModel.fromJson(json) {
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

import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
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
  String category;
  String subCategory;
  Timestamp createdAt;
  Timestamp updatedAt;
  bool isSuspended = false;

  ItemModel({
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
    required this.category,
    required this.subCategory,
    required this.createdAt,
    required this.updatedAt,
    this.isSuspended = false,
  });

  // Convert from JSON
  factory ItemModel.fromJson(json) {
    return ItemModel(
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
      category: json['category'],
      subCategory: json['subCategory'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isSuspended: json['isSuspended'] ?? false,
    );
  }

  // Convert to JSON
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
      'category': category,
      'subCategory': subCategory,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isSuspended': isSuspended,
    };
  }
}

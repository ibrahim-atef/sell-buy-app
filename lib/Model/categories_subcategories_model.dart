import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String id;
  String name;
  String arName; // Arabic name field
  String imagePath;
  List<Subcategory> ?subcategories;
  Timestamp createdAt;
  Timestamp updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.arName, // Initialize Arabic name
    required this.imagePath,
    required this.subcategories,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert Category to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'arName': arName,
      'imageURL': imagePath,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a Category from a Firestore-compatible map
  factory Category.fromMap(map) {
    return Category(
      id: map['id'],
      name: map['name'],
      arName: map['arName'],
      imagePath: map['imageURL'],
      subcategories: map['subcategories'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}

class Subcategory {
  String id;
  String name;
  String arName; // Arabic name field
  String imagePath;
  String categoryId;
  Timestamp createdAt;
  Timestamp updatedAt;

  Subcategory({
    required this.id,
    required this.name,
    required this.arName, // Initialize Arabic name
    required this.imagePath,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert Subcategory to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'arName': arName,
      'imageURL': imagePath,
      'categoryId': categoryId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a Subcategory from a Firestore-compatible map
  factory Subcategory.fromMap(map) {
    return Subcategory(
      id: map['id'],
      name: map['name'],
      arName: map['arName'],
      imagePath: map['imageURL'],
      categoryId: map['categoryId'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}

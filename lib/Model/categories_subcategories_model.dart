import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String id;
  String name;
  String arName; // Arabic name field
  String imagePath;
  List<Subcategory>? subcategories; // Updated to include list of subcategories
  Timestamp createdAt;
  Timestamp updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.arName,
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
  factory Category.fromMap(  map) {
    return Category(
      id: map['id'],
      name: map['name'],
      arName: map['arName'],
      imagePath: map['imageURL'],
      subcategories: (map['subcategories'] as List?)
          ?.map((item) => Subcategory.fromMap(item))
          .toList(), // Convert list of maps to list of Subcategory objects
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
  List<LastSubcategory>? subcategories; // Add third-level subcategories

  Subcategory({
    required this.id,
    required this.name,
    required this.arName,
    required this.imagePath,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    this.subcategories,
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
      'subcategories': subcategories?.map((sub) => sub.toMap()).toList(),
    };
  }

  // Create a Subcategory from a Firestore-compatible map
  factory Subcategory.fromMap(  map) {
    return Subcategory(
      id: map['id'],
      name: map['name'],
      arName: map['arName'],
      imagePath: map['imageURL'],
      categoryId: map['categoryId'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      subcategories: (map['subcategories'] as List?)
          ?.map((item) => LastSubcategory.fromMap(item))
          .toList(), // Convert list of maps to list of Subcategory objects
    );
  }
}
class LastSubcategory {
  String id;
  String name;
  String arName; // Arabic name field
  String imagePath;
  String categoryId;
  String subcategoryId;
  Timestamp createdAt;
  Timestamp updatedAt;

  LastSubcategory({
    required this.id,
    required this.name,
    required this.arName, // Initialize Arabic name
    required this.imagePath,
    required this.categoryId,
    required this.subcategoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert LastSubcategory to a Firestore-compatible map
  toMap() {
    return {
      'id': id,
      'name': name,
      'arName': arName,
      'imageURL': imagePath,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory LastSubcategory.fromMap(map) {
    return LastSubcategory(
      id: map['id'],
      name: map['name'],
      arName: map['arName'],
      imagePath: map['imageURL'],
      categoryId: map['categoryId'],
      subcategoryId: map['subcategoryId'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}
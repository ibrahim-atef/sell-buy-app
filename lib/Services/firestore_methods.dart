import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sell_buy/Model/ad_model.dart';
import 'package:sell_buy/Model/categories_subcategories_model.dart';
import 'package:sell_buy/Utilities/my_strings.dart';
import 'package:path/path.dart';
import '../Model/user_data_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreMethods {
  // Collection reference remains static as we don't need instance-specific references.
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(usersCollectionKey);
  static final CollectionReference usersAddsCollection =
      FirebaseFirestore.instance.collection(usersAddsCollectionKey);
  static final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection(categoriesCollectionKey);

  /// Create a new user document in Firestore
  static Future<void> createUser({required UserDataModel userDataModel}) async {
    try {
      await usersCollection.doc(userDataModel.uid).set(userDataModel.toJson());
    } catch (error) {
      throw Exception("Failed to create user: $error");
    }
  }

  /// Fetch user data by UID
  static Future<UserDataModel?> getUserByUID(String uid) async {
    try {
      DocumentSnapshot doc = await usersCollection.doc(uid).get();
      if (doc.exists) {
        return UserDataModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (error) {
      throw Exception("Failed to fetch user: $error");
    }
    return null;
  }

  /// Update an existing user document in Firestore
  Future<void> updateUser({required UserDataModel userModel}) async {
    await usersCollection.doc(userModel.uid).update(userModel.toJson());
  }

  // Add a new favorite item to the user subcollection
  static Future<void> addAdToFavourites(
      {required String uid, required AdModel favoriteItem}) async {
    try {
      await usersCollection.doc(uid).collection(favoritesCollectionKey).doc(favoriteItem.id).set(favoriteItem.toJson());
    } catch (error) {
      throw Exception("Failed to add favorite: $error");
    }
  }

  // Remove a favorite item from the user subcollection
  static Future<void> removeAdFromFavourites(
      {required String uid, required String adId}) async {
    try {
      await usersCollection
          .doc(uid)
          .collection(favoritesCollectionKey)
          .doc(adId)
          .delete();
    } catch (error) {
      throw Exception("Failed to remove favorite: $error");
    }
  }

  // Add a saved search for a user
  static Future<void> addSavedSearch(
      {required String uid, required Map<String, dynamic> savedSearch}) async {
    try {
      await usersCollection
          .doc(uid)
          .collection('saved_searches')
          .add(savedSearch);
    } catch (error) {
      throw Exception("Failed to add saved search: $error");
    }
  }

  // Add a review for a user
  static Future<void> addReview(
      {required String uid, required Map<String, dynamic> review}) async {
    try {
      await usersCollection.doc(uid).collection('reviews').add(review);
    } catch (error) {
      throw Exception("Failed to add review: $error");
    }
  }

  /// Helper function to upload a file to Firebase Storage
  static Future<String> uploadFileToFirebaseStorage(File file) async {
    try {
      String fileName = basename(file.path); // Get the file name
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('ads/$fileName');
      TaskSnapshot uploadTask = await firebaseStorageRef.putFile(file);
      String downloadURL =
          await uploadTask.ref.getDownloadURL(); // Get the URL after uploading
      return downloadURL;
    } catch (e) {
      print('Error uploading file to Firebase Storage: $e');
      rethrow; // Propagate the error for further handling
    }
  }

  /// Get categories from Firestore
  static Future<List<Category>> getCategories() async {
    List<Category> categories = [];

    try {
      QuerySnapshot snapshot = await categoriesCollection.get();

      // Loop through documents and add category names to the list
      for (DocumentSnapshot doc in snapshot.docs) {
        if (doc.exists && doc.data() != null) {
          categories.add(Category.fromMap(doc.data() as Map<String, dynamic>));
        }
      }
    } catch (error) {
      print("Error getting categories: $error");
      // You could throw the error further if you want to handle it elsewhere
      throw Exception("Failed to load categories");
    }

    return categories;
  }

  static Future<void> addViewToAd({
    required String uid,
    required String adId,
    required String categoryCollection,
  }) async {
    debugPrint(
        "Adding view to ad: uid: $uid, adId: $adId, categoryCollection: $categoryCollection");
    if (uid.isEmpty || adId.isEmpty || categoryCollection.isEmpty) {
      throw Exception(
          "Invalid parameters: uid, adId, and categoryCollection must be non-empty.");
    }

    try {
      await FirebaseFirestore.instance
          .collection(categoryCollection)
          .doc(adId)
          .collection(viewsCollectionKey)
          .doc(uid)
          .set({});
    } catch (error) {
      print("Error adding view to ad: $error");
      throw Exception("Failed to add view to ad");
    }
  }

  static Future<int> getViewsCount(
      {required String adId, required String categoryCollection}) async {
    try {
      QuerySnapshot? snapshot = await FirebaseFirestore.instance
          .collection(categoryCollection)
          .doc(adId)
          .collection(viewsCollectionKey)
          .get();
      return snapshot?.docs.length ?? 0;
    } catch (error) {
      print("Error getting views count: $error");
      throw Exception("Failed to get views count");
    }
  }


}

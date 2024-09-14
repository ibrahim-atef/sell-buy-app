import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:sell_buy/utilities/my_strings.dart';

import '../Model/user_data_model.dart';

class FireStoreMethods {
  // Collection reference remains static as we don't need instance-specific references.
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(usersCollectionKey);

  /// Create a new user document in Firestore
  static Future<void> createUser({required UserDataModel userDataModel}) async {
    try {
      await usersCollection.doc(userDataModel.uid).set(userDataModel.toJson());
    } catch (error) {
      throw Exception("Failed to create user: $error");
    }
  }

  /// Update an existing user document in Firestore
  static Future<void> updateUser({required UserDataModel userModel}) async {
    try {
      await usersCollection.doc(userModel.uid).update(userModel.toJson());
    } catch (error) {
      throw Exception("Failed to update user: $error");
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

  /// Delete a user by UID
  static Future<void> deleteUser(String uid) async {
    try {
      await usersCollection.doc(uid).delete();
    } catch (error) {
      throw Exception("Failed to delete user: $error");
    }
  }

  /// Fetch all users (paginated or filtered can be added later)
  static Future<List<UserDataModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await usersCollection.get();
      return querySnapshot.docs
          .map((doc) => UserDataModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (error) {
      throw Exception("Failed to fetch users: $error");
    }
  }

  /// Update the user's activation status
  static Future<void> updateUserActivationStatus(
      {required String uid, required bool isActivated}) async {
    try {
      await usersCollection.doc(uid).update({'isActivated': isActivated});
    } catch (error) {
      throw Exception("Failed to update activation status: $error");
    }
  }

  /// Update the FCM token
  static Future<void> updateUserFCMToken(
      {required String uid, required String fcmToken}) async {
    try {
      await usersCollection.doc(uid).update({'fcmToken': fcmToken});
    } catch (error) {
      throw Exception("Failed to update FCM token: $error");
    }
  }

  // Add a new favorite item to the user subcollection
  static Future<void> addFavorite(
      {required String uid, required Map<String, dynamic> favoriteItem}) async {
    try {
      await usersCollection.doc(uid).collection('favorites').add(favoriteItem);
    } catch (error) {
      throw Exception("Failed to add favorite: $error");
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
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sell_buy/model/user_data_model.dart';
import 'package:sell_buy/utilities/my_strings.dart';



class FireStoreMethods {

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(usersCollectionKey);


  Future<void> createUser({required UserModel userModel}) async {
    try {
      await usersCollection.doc(userModel.uid).set(userModel.toJson());
    } catch (error) {
      throw Exception("Failed to create user: $error");
    }
  }



  Future<void> updateUser({required UserModel userModel}) async {
    await usersCollection.doc(userModel.uid).update(userModel.toJson());
  }


}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sell_buy/model/user_data_model.dart';
import 'package:sell_buy/utilities/my_strings.dart';



class FireStoreMethods {
  final CollectionReference healthInstitutionCollection =
      FirebaseFirestore.instance.collection(healthInstitutionCollectionKey);
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(usersCollectionKey);
  final CollectionReference treatmentRequestsCollection =
      FirebaseFirestore.instance.collection(treatmentRequestsCollectionKey);

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


  Stream<QuerySnapshot> getTreatmentRequestsByHealthInstitutionId(
      String healthInstitutionId) {
    return treatmentRequestsCollection
        .where('healthInstitutionID', isEqualTo: healthInstitutionId)
        .orderBy('updatedAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getTreatmentRequestsForMyLoggedUser(String userId) {
    return treatmentRequestsCollection
        .where('requesterID', isEqualTo: userId)
        .orderBy('updatedAt', descending: true)
        .snapshots();
  }
}

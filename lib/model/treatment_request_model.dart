import 'package:cloud_firestore/cloud_firestore.dart';

class TreatmentRequestModel {
  final String? userFcmToken;
  final String? treatmentId;
  final String? patientName;

  /// this serial number is patient Id this is naming conviction mistake by me and  i was too lazy to do it
  final String? serialNumber;
  final String? healthInstitutionID;
  final String? healthInstitutionFcmToken;
  final String? healthInstitution;
  final String? notes;
  final String? deliverNotes;
  final TreatmentStatus? status;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final String? requesterID;
  final String? requesterName;
  final String? clinic;
  final String? patientNumber;
  final bool? hasBeenRead;

  /// this is the incremented serial number for the delivered treatment
  final int? treatmentSerialNum;

  TreatmentRequestModel({
    required this.treatmentId,
    this.userFcmToken,
    this.patientName,
    required this.healthInstitutionFcmToken,
    required this.deliverNotes,
    this.serialNumber,
    this.healthInstitutionID,
    this.healthInstitution,
    this.notes,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.requesterID,
    this.requesterName,
    required this.clinic,
    required this.patientNumber,
    required this.treatmentSerialNum,
    required this.hasBeenRead,
  });

  factory TreatmentRequestModel.fromMap(Map<String, dynamic> map) {
    return TreatmentRequestModel(
      treatmentId: map['treatmentId'],
      userFcmToken: map['userFcmToken'],
      patientName: map['patientName'],
      healthInstitutionFcmToken: map['healthInstitutionFcmToken'],
      deliverNotes: map['deliverNotes'],
      serialNumber: map['serialNumber'],
      healthInstitutionID: map['healthInstitutionID'],
      healthInstitution: map['healthInstitution'],
      notes: map['notes'],
      status: map.containsKey('orderStatus')
          ? TreatmentStatus.values[map['status']]
          : null,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      requesterID: map['requesterID'],
      requesterName: map['requesterName'],
      clinic: map['clinic'],
      patientNumber: map['patientNumber'],
      treatmentSerialNum: map['treatmentSerialNum'],
      hasBeenRead: map['hasBeenRead'],
    );
  }

  factory TreatmentRequestModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return TreatmentRequestModel(
      treatmentId: doc['treatmentId'],
      userFcmToken: doc['userFcmToken'],
      patientName: doc['patientName'],
      healthInstitutionFcmToken: doc['healthInstitutionFcmToken'],
      deliverNotes: doc['deliverNotes'],
      serialNumber: doc['serialNumber'],
      healthInstitutionID: doc['healthInstitutionID'],
      healthInstitution: doc['healthInstitution'],
      notes: doc['notes'],
      status: TreatmentStatus.values[doc['status']],
      createdAt: doc['createdAt'],
      updatedAt: doc['updatedAt'],
      requesterID: doc['requesterID'],
      requesterName: doc['requesterName'],
      clinic: doc['clinic'],
      patientNumber: doc['patientNumber'],
      treatmentSerialNum: doc['treatmentSerialNum'],
      hasBeenRead: doc['hasBeenRead'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'treatmentId': treatmentId,
      'userFcmToken': userFcmToken,
      'patientName': patientName,
      'deliverNotes': deliverNotes,
      'healthInstitutionFcmToken': healthInstitutionFcmToken,
      'serialNumber': serialNumber,
      'healthInstitutionID': healthInstitutionID,
      'healthInstitution': healthInstitution,
      'notes': notes,
      'status': status?.index,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'requesterID': requesterID,
      'requesterName': requesterName,
      'clinic': clinic,
      'patientNumber': patientNumber,
      'treatmentSerialNum': treatmentSerialNum,
      'hasBeenRead': hasBeenRead,
    };
  }
}

enum TreatmentStatus {
  inProgress,
  delivered,
  canceled,
}

class PatientModel {
  String serialNumber;
  String patientNumber;
  String patientName;
  String healthInstitution;
  String healthInstitutionID;
  String healthInstitutionFcmToken;
  String notes;
  String deliverNotes;

  PatientModel({
    required this.serialNumber,
    required this.patientNumber,
    required this.patientName,
    required this.healthInstitutionID,
    required this.healthInstitution,
    required this.healthInstitutionFcmToken,
    this.notes = "",
    this.deliverNotes = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'serialNumber': serialNumber,
      'patientNumber': patientNumber,
      'patientName': patientName,
      'healthInstitutionID': healthInstitutionID,
      'healthInstitution': healthInstitution,
      'healthInstitutionFcmToken': healthInstitutionFcmToken,
      'notes': notes,
      'deliverNotes': deliverNotes,
    };
  }

  factory PatientModel.fromMap(map) {
    return PatientModel(
      serialNumber: map['serialNumber'],
      patientNumber: map['patientNumber'],
      patientName: map['patientName'],
      healthInstitution: map['healthInstitution'],
      healthInstitutionFcmToken: map['healthInstitutionFcmToken'],
      notes: map['notes'],
      deliverNotes: map['deliverNotes'],
      healthInstitutionID: map["healthInstitutionID"],
    );
  }
}

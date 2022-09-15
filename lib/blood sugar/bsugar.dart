import 'package:cloud_firestore/cloud_firestore.dart';

class BSugarModel {
  String id;
  double bloodSugarLevel;
  String userId;
  Timestamp date;
  String status;

  BSugarModel(
      {this.id, this.bloodSugarLevel, this.userId, this.date, this.status});

  factory BSugarModel.fromJson(DocumentSnapshot snapshot) {
    return BSugarModel(
        id: snapshot.id,
        bloodSugarLevel: snapshot['bloodSugarLevel'],
        date: snapshot['date'],
        status: snapshot['status'],
        userId: snapshot['userId']);
  }
}

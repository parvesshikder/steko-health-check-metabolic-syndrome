import 'package:cloud_firestore/cloud_firestore.dart';

class BPressureModel {
  String id;
  double dia;
  double sys;
  String userId;
  Timestamp date;
  String status;

  BPressureModel(
      {this.id, this.dia, this.sys, this.userId, this.date, this.status});

  factory BPressureModel.fromJson(DocumentSnapshot snapshot) {
    return BPressureModel(
        id: snapshot.id,
        dia: snapshot['dia'],
        sys: snapshot['sys'],
        date: snapshot['date'],
        status: snapshot['status'],
        userId: snapshot['userId']);
  }
}

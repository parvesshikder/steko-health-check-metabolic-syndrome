import 'package:cloud_firestore/cloud_firestore.dart';

class SleepModel {
  String id;
  double sleepHour;
  String userId;
  Timestamp date;
  String status;

  SleepModel({this.id, this.sleepHour, this.userId, this.date, this.status});

  factory SleepModel.fromJson(DocumentSnapshot snapshot) {
    return SleepModel(
        id: snapshot.id,
        sleepHour: snapshot['sleepHour'],
        date: snapshot['date'],
        status: snapshot['status'],
        userId: snapshot['userId']);
  }
}

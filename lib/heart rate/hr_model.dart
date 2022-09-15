import 'package:cloud_firestore/cloud_firestore.dart';

class HeartRateModel {
  String id;
  double heartRate;
  String userId;
  Timestamp date;
  String status;

  HeartRateModel(
      {this.id, this.heartRate, this.userId, this.date, this.status});

  factory HeartRateModel.fromJson(DocumentSnapshot snapshot) {
    return HeartRateModel(
      id: snapshot.id,
      heartRate: snapshot['heartRate'],
      date: snapshot['date'],
      status: snapshot['status'],
      userId: snapshot['userId'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class BMIModel {
  String id;
  double bmi;
  String userId;
  Timestamp date;
  String result;

  BMIModel({this.id, this.bmi, this.userId, this.date, this.result});

  factory BMIModel.fromJson(DocumentSnapshot snapshot) {
    return BMIModel(
        id: snapshot.id,
        bmi: snapshot['bmi'],
        date: snapshot['date'],
        result: snapshot['result'],
        userId: snapshot['userId']);
  }
}

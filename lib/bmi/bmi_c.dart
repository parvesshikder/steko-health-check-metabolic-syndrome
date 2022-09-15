import 'package:cloud_firestore/cloud_firestore.dart';

class BMIModel {
  String id;
  double  bmi;
  String userId;
  String comment;
  String result;

  BMIModel({this.id, this.bmi, this.userId, this.comment, this.result});

  factory BMIModel.fromJson(DocumentSnapshot snapshot) {
    return BMIModel(
        id: snapshot.id,
        bmi: snapshot['bmi'],
        comment: snapshot['comment'],
        result: snapshot['result'],
        userId: snapshot['userId']);
        
  }
}

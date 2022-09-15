import 'package:cloud_firestore/cloud_firestore.dart';

class CaloriesModel {
  String id;
  double totalCalories;
  String userId;
  Timestamp date;
  String mealTime;

  CaloriesModel(
      {this.id, this.totalCalories, this.userId, this.date, this.mealTime});

  factory CaloriesModel.fromJson(DocumentSnapshot snapshot) {
    return CaloriesModel(
        id: snapshot.id,
        totalCalories: snapshot['totalCalories'],
        date: snapshot['date'],
        mealTime: snapshot['mealTime'],
        userId: snapshot['userId']);
  }
}

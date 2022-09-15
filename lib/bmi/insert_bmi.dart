import 'package:cloud_firestore/cloud_firestore.dart';

class InsertBMIData {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<void> inserBMIData(
      {double bmi, String userId, String comment, String result}) async {
    try {
      await firebase.collection("BMI").add({
        'bmi': bmi,
        'userId': userId,
        'comment': comment,
        'result': result,
        'date': DateTime.now(),
        'timestamp': DateTime.now().microsecondsSinceEpoch,
      });

      // ignore: empty_catches
    } catch (e) {}
  }
}

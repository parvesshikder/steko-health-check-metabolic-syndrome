import 'package:cloud_firestore/cloud_firestore.dart';

class InsertbloodPressureLevelData {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<void> inserBloodPressureData(
      {double dia, double sys, String userId, String status}) async {
    try {
      await firebase.collection("BloodPressure").add({
        'dia': dia,
        'sys': sys,
        'userId': userId,
        'date': DateTime.now(),
        'status': status,
        'timestamp': DateTime.now().microsecondsSinceEpoch,
      });

      // ignore: empty_catches
    } catch (e) {}
  }
}

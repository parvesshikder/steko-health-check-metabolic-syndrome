import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InsertHeartRateData {
  final myUserId = FirebaseAuth.instance.currentUser.uid;

  var date = DateTime.now();

  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<void> insertHeartRateData(
      {double heartRate, String userId, String status}) async {
    try {
      await firebase.collection("HeartRate").add({
        'heartRate': heartRate,
        'userId': userId,
        'status': status,
        'date': DateTime.now(),
        'timestamp': DateTime.now().microsecondsSinceEpoch,
      });

      // ignore: empty_catches
    } catch (e) {}
  }
}

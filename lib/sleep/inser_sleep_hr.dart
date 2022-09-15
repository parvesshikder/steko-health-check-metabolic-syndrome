import 'package:cloud_firestore/cloud_firestore.dart';

class InsertSleepHourData {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<void> inserSleepHourData(
      {double sleepHour, String userId, String status}) async {
    try {
      await firebase.collection("SleepHour").add({
        'sleepHour': sleepHour,
        'userId': userId,
        'date': DateTime.now(),
        'status': status,
        'timestamp': DateTime.now().microsecondsSinceEpoch,
      });

      // ignore: empty_catches
    } catch (e) {}
  }
}

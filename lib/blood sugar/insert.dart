import 'package:cloud_firestore/cloud_firestore.dart';

class InsertbloodSugarLevelData {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<void> inserBloodSugarData(
      {double bloodSugarLevel, String userId, String status}) async {
    try {
      await firebase.collection("BloodSugar").add({
        'bloodSugarLevel': bloodSugarLevel,
        'userId': userId,
        'date': DateTime.now(),
        'status': status,
        'timestamp': DateTime.now().microsecondsSinceEpoch,
        
      });

      // ignore: empty_catches
    } catch (e) {}
  }
}

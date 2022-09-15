import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

DateTime today = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(today);

class InsertCaloriesData {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<void> inserCaloriesData(
      {double totalCalories, String userId, String mealTime}) async {
    try {
      await firebase.collection("CaloriesIntake").add({
        'totalCalories': totalCalories,
        'userId': userId,
        'date': formatted,
        'mealTime': mealTime,
        'timestamp': DateTime.now().microsecondsSinceEpoch,
      });

      // ignore: empty_catches
    } catch (e) {}
  }
}

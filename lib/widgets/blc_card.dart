import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BlcScreen extends StatefulWidget {
  const BlcScreen({Key key}) : super(key: key);

  @override
  State<BlcScreen> createState() => _BlcScreenState();
}

class _BlcScreenState extends State<BlcScreen> {
  double totalCalories = 0;
  double mcalories = 0;
  double lcalories = 0;
  double dcalories = 0;
  bool loading = false;
  bool loading2 = false;
  double percentage = 0;
  double totalSleepHour = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  double blodSugarLevel;

  final user = FirebaseAuth.instance.currentUser;

  Future<dynamic> getData() async {
    FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

    //blood sugar
    var res = await firestoreInstance
        .collection("BloodSugar")
        .where("userId", isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .get();

    if (res.docs.isNotEmpty) {
      setState(() {
        blodSugarLevel = res.docs.first.data()['bloodSugarLevel'];
      });
    }

    //calories intake
    loading2 = true;

    DateTime today = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(today);

    var bfast = await firestoreInstance
        .collection("CaloriesIntake")
        .where("userId", isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .where("mealTime", isEqualTo: "Breakfast")
        .where("date", isEqualTo: formatted)
        .limit(1)
        .get();

    var lunch = await firestoreInstance
        .collection("CaloriesIntake")
        .where("userId", isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .where("mealTime", isEqualTo: "Lunch")
        .where("date", isEqualTo: formatted)
        .limit(1)
        .get();

    var dinner = await firestoreInstance
        .collection("CaloriesIntake")
        .where("userId", isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .where("mealTime", isEqualTo: "Dinner")
        .where("date", isEqualTo: formatted)
        .limit(1)
        .get();

    if (bfast.docs.isNotEmpty) {
      setState(() {
        mcalories = bfast.docs.first.data()['totalCalories'];
      });
    } else {
      mcalories = 0;
    }

    if (lunch.docs.isNotEmpty) {
      setState(() {
        lcalories = lunch.docs.first.data()['totalCalories'];
      });
    } else {
      lcalories = 0;
    }

    if (dinner.docs.isNotEmpty) {
      setState(() {
        dcalories = lunch.docs.first.data()['totalCalories'];
      });
    } else {
      dcalories = 0;
    }

    totalCalories = mcalories + lcalories + dcalories;

    if (totalCalories != null) {
      setState(() {
        if (totalCalories > 0 && totalCalories < 500) {
          percentage = 0.25;
        } else if (totalCalories > 500 && totalCalories < 1000) {
          percentage = 0.5;
        } else if (totalCalories > 1000 && totalCalories < 1500) {
          percentage = 0.75;
        } else if (totalCalories > 1000 && totalCalories < 1500) {
          percentage = 0.1;
        }
      });
    }
    loading2 = false;

    //sleep
    //blood pressure
    var sleep = await firestoreInstance
        .collection("SleepHour")
        .where("userId", isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .get();

    if (sleep.docs.isNotEmpty) {
      setState(() {
        totalSleepHour = sleep.docs.first.data()['sleepHour'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 315,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    height: 275,
                    width: 15,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8F8),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: FAProgressBar(
                      borderRadius: BorderRadius.circular(30.0),
                      direction: Axis.vertical,
                      verticalDirection: VerticalDirection.up,
                      currentValue:
                          blodSugarLevel == null ? 0 : blodSugarLevel * 10,
                      progressColor: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    width: .0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Blood Sugar',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D242A),
                        ),
                      ),
                      blodSugarLevel == null
                          ? Text(
                              '0',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..shader = const LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF8BBC45),
                                      Color(0xFF4BB845),
                                      //add more color here.
                                    ],
                                  ).createShader(
                                    const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                                  ),
                              ),
                            )
                          : Text(
                              '$blodSugarLevel',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..shader = const LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF8BBC45),
                                      Color(0xFF4BB845),
                                      //add more color here.
                                    ],
                                  ).createShader(
                                    const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                                  ),
                              ),
                            ),
                      Image.asset(
                        'assets/images/graphbar.png',
                        scale: 1.8,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Last Night Sleep',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D242A),
                          ),
                        ),
                        Text(
                          '${totalSleepHour.round()} hr',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = const LinearGradient(
                                colors: <Color>[
                                  Color(0xFF8BBC45),
                                  Color(0xFF4BB845),
                                  //add more color here.
                                ],
                              ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                              ),
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/Vector-sleep.png',
                            scale: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Calories Intake',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D242A),
                          ),
                        ),
                        Center(
                          child: CircularPercentIndicator(
                            radius: 40.0,
                            lineWidth: 5.0,
                            percent: percentage,
                            backgroundColor:
                                const Color(0xFF4BB845).withOpacity(0.1),
                            progressColor: const Color(0xFF4BB845),
                            center: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  totalCalories != null
                                      ? Text(
                                          '${totalCalories.floor()}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          '${0}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                ],
                              ),
                              height: 64,
                              width: 64,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xFF8BBC45),
                                    Color(0xFF4BB845),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

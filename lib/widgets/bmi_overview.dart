import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../bmi/bmi_calculation_screen.dart';
import '../constraints.dart';
import '../custom route/slide_right_route.dart';

class BMIOverview extends StatefulWidget {
  const BMIOverview({Key key}) : super(key: key);

  @override
  State<BMIOverview> createState() => _BMIOverviewState();
}

class _BMIOverviewState extends State<BMIOverview> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  String result;
  double bmi;
  dynamic data;

  final user = FirebaseAuth.instance.currentUser;

  Future<dynamic> getData() async {
    FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

    var res = await firestoreInstance
        .collection("BMI")
        .where("userId", isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .get();

    if (res.docs.isNotEmpty) {
      setState(() {
        bmi = res.docs.first.data()['bmi'];
        result = res.docs.first.data()['result'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        //stake
        Stack(
      children: [
        Column(
          children: [
            Image.asset('assets/images/Banner.png'),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'BMI (Body Mass Index)',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      result == null
                          ? const Text(
                              // ignore: unnecessary_string_interpolations
                              'No records found',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              // ignore: unnecessary_string_interpolations
                              '$result',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: 95,
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: kYelloGradientColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              SlideRightRoute(
                                page: const BMICalculator(),
                              ),
                            );
                          },
                          child: const Text(
                            'Calculate',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      'assets/images/Banner--Pie-Ellipse.png',
                    ),
                    bmi != null
                        ? Text(
                            bmi.toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            '0.0',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

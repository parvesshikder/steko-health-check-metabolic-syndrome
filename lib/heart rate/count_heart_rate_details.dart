// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:steko_health_checker/constraints.dart';
import '../main.dart';

import 'heart_rate.dart';
import 'insert_heart_rate.dart';

// showNotification() async {
//   // ignore: prefer_const_constructors
//   var android = AndroidNotificationDetails('channel id', 'channel NAME',
//       priority: Priority.high, importance: Importance.max);
//   var platform = NotificationDetails(android: android);
//   await flutterLocalNotificationsPlugin.show(
//       0, 'Alert from Steko health Checker', 'Heart Rate. ', platform,
//       payload:
//           'Your Heart Rate is not normal, make an appointment to see a health care provider. ');
// }

class CountHeartRateDetails extends StatefulWidget {
  const CountHeartRateDetails({Key key}) : super(key: key);

  @override
  State<CountHeartRateDetails> createState() => _CountHeartRateDetailsState();
}

class _CountHeartRateDetailsState extends State<CountHeartRateDetails> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initSetttings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  // ignore: missing_return
  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Notification'),
        content: Text(payload),
      ),
    );
  }

  final myUserId = FirebaseAuth.instance.currentUser.uid;

  TextEditingController ageController = TextEditingController();
  TextEditingController heartRateController = TextEditingController();

  String status = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'Heart Rate',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 400,
                    child: const HeartRate()),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Records',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F1E5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Alert(
                                  context: context,
                                  title: "Heart Rate",
                                  content: Column(
                                    children: <Widget>[
                                      TextField(
                                        controller: ageController,
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          labelText: 'Enter Your Age',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextField(
                                        controller: heartRateController,
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          labelText: 'Enter Heart Rate',
                                        ),
                                      ),
                                    ],
                                  ),
                                  buttons: [
                                    loading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : DialogButton(
                                            gradient: kGreenGradientColor,
                                            onPressed: () async {
                                              double hr = double.parse(
                                                  heartRateController.text);
                                              int age =
                                                  int.parse(ageController.text);
                                              if (heartRateController
                                                  .text.isNotEmpty) {
                                                if (age >= 20 && age <= 29) {
                                                  if (hr >= 100 && hr <= 170) {
                                                    status = 'Normal';
                                                  } else if (hr < 100) {
                                                    status = 'Low';
                                                  } else if (hr > 170) {
                                                    status = 'High';
                                                  }
                                                } else if (age >= 30 &&
                                                    age <= 34) {
                                                  if (hr >= 95 && hr <= 162) {
                                                    status = 'Normal';
                                                  } else if (hr < 95) {
                                                    status = 'Low';
                                                  } else if (hr > 162) {
                                                    status = 'High';
                                                  }
                                                } else if (age >= 35 &&
                                                    age <= 39) {
                                                  if (hr >= 93 && hr <= 157) {
                                                    status = 'Normal';
                                                  } else if (hr < 93) {
                                                    status = 'Low';
                                                  } else if (hr > 157) {
                                                    status = 'High';
                                                  }
                                                } else if (age >= 40 &&
                                                    age <= 44) {
                                                  if (hr >= 90 && hr <= 153) {
                                                    status = 'Normal';
                                                  } else if (hr < 90) {
                                                    status = 'Low';
                                                  } else if (hr > 153) {
                                                    status = 'High';
                                                  }
                                                } else if (age >= 45 &&
                                                    age <= 49) {
                                                  if (hr >= 88 && hr <= 149) {
                                                    status = 'Normal';
                                                  } else if (hr < 88) {
                                                    status = 'Low';
                                                  } else if (hr > 149) {
                                                    status = 'High';
                                                  }
                                                } else if (age >= 50 &&
                                                    age <= 54) {
                                                  if (hr >= 85 && hr <= 145) {
                                                    status = 'Normal';
                                                  } else if (hr < 85) {
                                                    status = 'Low';
                                                  } else if (hr > 145) {
                                                    status = 'High';
                                                  }
                                                } else if (age >= 55 &&
                                                    age <= 59) {
                                                  if (hr >= 83 && hr <= 140) {
                                                    status = 'Normal';
                                                  } else if (hr < 83) {
                                                    status = 'Low';
                                                  } else if (hr > 140) {
                                                    status = 'High';
                                                  }
                                                } else if (age >= 60 &&
                                                    age <= 64) {
                                                  if (hr >= 80 && hr <= 136) {
                                                    status = 'Normal';
                                                  } else if (hr < 80) {
                                                    status = 'Low';
                                                  } else if (hr > 136) {
                                                    status = 'High';
                                                  }
                                                } else if (age >= 65 &&
                                                    age <= 69) {
                                                  if (hr >= 78 && hr <= 132) {
                                                    status = 'Normal';
                                                  } else if (hr < 78) {
                                                    status = 'Low';
                                                  } else if (hr > 132) {
                                                    status = 'High';
                                                  }
                                                } else if (age >= 70) {
                                                  if (hr >= 75 && hr <= 128) {
                                                    status = 'Normal';
                                                  } else if (hr < 75) {
                                                    status = 'Low';
                                                  } else if (hr > 128) {
                                                    status = 'High';
                                                  }
                                                }

                                                setState(() {
                                                  loading = true;
                                                });

                                                await InsertHeartRateData()
                                                    .insertHeartRateData(
                                                  heartRate: hr,
                                                  status: status,
                                                  userId: myUserId,
                                                );

                                                // greenAlertDialog(context);

                                                setState(() {
                                                  loading = false;
                                                });

                                                Navigator.pop(context);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text('Null Value'),
                                                  backgroundColor: Colors.red,
                                                ));
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text(
                                              "ADD",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          )
                                  ]).show();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                gradient: kGreenGradientColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Heart Rate',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF1D1617),
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

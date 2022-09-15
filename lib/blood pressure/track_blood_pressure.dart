import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:steko_health_checker/blood%20pressure/blood_pressure.dart';
import 'package:steko_health_checker/constraints.dart';

import 'insert_blood_pressure.dart';

// showNotification() async {
//   // ignore: prefer_const_constructors
//   var android = AndroidNotificationDetails('channel id', 'channel NAME',
//       priority: Priority.high, importance: Importance.max);
//   var platform = NotificationDetails(android: android);
//   await flutterLocalNotificationsPlugin.show(
//       0, 'Alert from Steko health Checker', 'Blood Pressure. ', platform,
//       payload:
//           'Your Blood Pressure level is not normal, make an appointment to see a health care provider. ');
// }

class BloodPressureLevel extends StatefulWidget {
  const BloodPressureLevel({Key key}) : super(key: key);

  @override
  State<BloodPressureLevel> createState() => _BloodPressureLevelState();
}

class _BloodPressureLevelState extends State<BloodPressureLevel> {
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

  TextEditingController bloodPressureControllerDIA = TextEditingController();
  TextEditingController bloodPressureControllerSYS = TextEditingController();

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
              'Blood Pressure',
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
                    child: const BloodPressure()),
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
                                  title: "Blood BloodPressure",
                                  content: Column(
                                    children: <Widget>[
                                      TextField(
                                        controller: bloodPressureControllerDIA,
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          labelText: 'Enter DIA',
                                        ),
                                      ),
                                      TextField(
                                        controller: bloodPressureControllerSYS,
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          labelText: 'Enter SYS',
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
                                              double sysVal = double.parse(
                                                  bloodPressureControllerSYS
                                                      .text);
                                              double diaVal = double.parse(
                                                  bloodPressureControllerDIA
                                                      .text);

                                              if (bloodPressureControllerDIA
                                                      .text.isNotEmpty &&
                                                  bloodPressureControllerSYS
                                                      .text.isNotEmpty) {
                                                if (sysVal <= 120 &&
                                                    diaVal <= 80) {
                                                  status = 'Normal';
                                                } else if (sysVal >= 120 &&
                                                    sysVal <= 129 &&
                                                    diaVal <= 80) {
                                                  status = 'Elevated';
                                                  //showNotification();
                                                } else if (sysVal >= 130 &&
                                                    sysVal <= 139 &&
                                                    diaVal > 80) {
                                                  status = 'High';
                                                  //showNotification();
                                                }

                                                setState(() {
                                                  loading = true;
                                                });

                                                await InsertbloodPressureLevelData()
                                                    .inserBloodPressureData(
                                                        dia: diaVal,
                                                        sys: sysVal,
                                                        userId: myUserId,
                                                        status: status);

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
                          const Text('Blood Pressure',
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

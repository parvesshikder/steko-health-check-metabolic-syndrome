// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:steko_health_checker/constraints.dart';
import 'package:steko_health_checker/blood%20sugar/blood_sugar.dart';
import '../main.dart';

import 'insert.dart';

// showNotification() async {
//   // ignore: prefer_const_constructors
//   var android = AndroidNotificationDetails('channel id', 'channel NAME',
//       priority: Priority.high, importance: Importance.max);
//   var platform = NotificationDetails(android: android);
//   await flutterLocalNotificationsPlugin.show(
//       0, 'Alert from Steko health Checker', 'Blood Sugar. ', platform,
//       payload:
//           'Your Blood Sugar level is not normal, make an appointment to see a health care provider. ');
// }

class BloodSugarLevel extends StatefulWidget {
  const BloodSugarLevel({Key key}) : super(key: key);

  @override
  State<BloodSugarLevel> createState() => _BloodSugarLevelState();
}

class _BloodSugarLevelState extends State<BloodSugarLevel> {
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

  TextEditingController bloodSugaeController = TextEditingController();

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
              'Blood Sugar',
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
                    child: const BloodSugar()),
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
                                  title: "Blood Sugar",
                                  content: Column(
                                    children: <Widget>[
                                      TextField(
                                        controller: bloodSugaeController,
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          labelText:
                                              'Enter Blood Sugar level (mmol/L)',
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
                                              double bs = double.parse(
                                                  bloodSugaeController.text);
                                              if (bloodSugaeController
                                                  .text.isNotEmpty) {
                                                if (bs < 3) {
                                                  status = 'Very Low';
                                                  //showNotification();
                                                } else if (bs > 3 && bs < 3.9) {
                                                  status = 'Low';
                                                  //showNotification();
                                                } else if (bs >= 3.9 &&
                                                    bs <= 7) {
                                                  status = 'Normal';
                                                } else if (bs > 7) {
                                                  status = 'High';
                                                  //showNotification();
                                                }

                                                setState(() {
                                                  loading = true;
                                                });

                                                await InsertbloodSugarLevelData()
                                                    .inserBloodSugarData(
                                                        bloodSugarLevel: bs,
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
                          const Text('Blood Sugar',
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

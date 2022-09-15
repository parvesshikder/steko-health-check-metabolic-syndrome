import 'package:duration_picker/duration_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steko_health_checker/constraints.dart';

import 'inser_sleep_hr.dart';
import 'sleep_hr_graph.dart';

class SleepTrackerScreen extends StatefulWidget {
  const SleepTrackerScreen({Key key}) : super(key: key);

  @override
  State<SleepTrackerScreen> createState() => _SleepTrackerScreenState();
}

class _SleepTrackerScreenState extends State<SleepTrackerScreen> {
  final myUserId = FirebaseAuth.instance.currentUser.uid;
  var date = DateTime.now();
  TextEditingController sleepRateController = TextEditingController();
  double sleepTime;

  bool loading = false;
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
              'Sleep Tracker',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 400,
                    child: const SleepHour()),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) => FloatingActionButton.extended(
            onPressed: () async {
              var resultingDuration = await showDurationPicker(
                decoration: const BoxDecoration(
                  gradient: kGreenGradientColor,
                  color: Colors.white,
                  backgroundBlendMode: BlendMode.colorBurn,
                ),
                context: context,
                initialTime: const Duration(hours: 7),
              );

              sleepTime = resultingDuration.inHours.toDouble();

              if (sleepTime != null) {
                if (sleepTime <= 9 && sleepTime >= 7) {
                  status = 'Normal';
                } else if (sleepTime > 9) {
                  status = 'Excessive';
                } else if (sleepTime < 7) {
                  status = 'Lack of Sleep';
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Null Value'),
                  backgroundColor: Colors.red,
                ));
              }

              setState(() {
                loading = true;
              });

              await InsertSleepHourData().inserSleepHourData(
                  sleepHour: resultingDuration.inHours.toDouble(),
                  userId: myUserId,
                  status: status);

              // greenAlertDialog(context);

              setState(() {
                loading = false;
              });
            },
            tooltip: 'Popup Duration Picker',
            label: const Text('Add Bed Time'),
            backgroundColor: Colors.green,
          ),
        ),
      ),
    );
  }
}

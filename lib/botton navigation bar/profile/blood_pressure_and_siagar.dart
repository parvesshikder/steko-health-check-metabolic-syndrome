import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class BloodPressureAndSugar extends StatefulWidget {
  const BloodPressureAndSugar({Key key}) : super(key: key);

  @override
  State<BloodPressureAndSugar> createState() => _BloodPressureAndSugarState();
}

class _BloodPressureAndSugarState extends State<BloodPressureAndSugar> {
  double heartRate = 0;
  double sys = 0;
  double dia = 0;
  String comment = '';

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    mydata();
  }

  FirebaseFirestore firebaseFire = FirebaseFirestore.instance;
  final myUserId = FirebaseAuth.instance.currentUser.uid;

  mydata() async {
    var bloodPressureVar = await firebaseFire
        .collection("BloodPressure")
        .where("userId", isEqualTo: myUserId)
        .get();

    if (bloodPressureVar.docs.isNotEmpty) {
      setState(() {
        dia = bloodPressureVar.docs.first.data()['dia'];
        sys = bloodPressureVar.docs.first.data()['sys'];
      });
    }

    var heartRateVar = await firebaseFire
        .collection("HeartRate")
        .where("userId", isEqualTo: myUserId)
        .get();

    if (heartRateVar.docs.isNotEmpty) {
      setState(() {
        heartRate = heartRateVar.docs.first.data()['heartRate'];
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/bmp_hr.png'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          margin: const EdgeInsets.only(top: 55.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dia != null
                      ? Text(
                          "${sys.round()} / ${dia.round()}",
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
                          "00 / 00",
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
                  heartRate != null
                      ? Text(
                          "${heartRate.round()} BPM",
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
                          "00 BPM",
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
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'SYS   /   DIA',
                      style: TextStyle(
                        color: Color(0xFF898484),
                        fontSize: 10.0,
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

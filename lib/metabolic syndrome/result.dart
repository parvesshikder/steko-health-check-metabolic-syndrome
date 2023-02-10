// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:steko_health_checker/botton%20navigation%20bar/main_page.dart';

import '../health_quiz/ui/shared/color.dart';

// ignore: must_be_immutable
class ResultScreenMS extends StatefulWidget {
  final int count;

  const ResultScreenMS({Key key, this.count}) : super(key: key);

  @override
  _ResultScreenMSState createState() => _ResultScreenMSState();
}

class _ResultScreenMSState extends State<ResultScreenMS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pripmaryColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: widget.count >= 3
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.warning,
                    size: 100,
                    color: Colors.red[600],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                      child: Text(
                    'You Have Metabolic Disease',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Eat healthy, regular exercise, reduce stress and drink plenty of water can help prevent or reverse metabolic syndrome.",
                    style: TextStyle(fontSize: 15, color: Colors.white60),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/2.png'),
                  const SizedBox(
                    height: 100.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondaryColor,
                      padding: const EdgeInsets.all(18.0),
                    ),
                    child: const Text(
                      "Back To Home",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.mood,
                      size: 150,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                        child: Text(
                      'You don\'t have metabolic syndrome risk.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondaryColor,
                        padding: const EdgeInsets.all(18.0),
                      ),
                      child: const Text(
                        "Back To Home",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

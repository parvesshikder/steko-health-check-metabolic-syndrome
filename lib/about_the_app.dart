import 'package:flutter/material.dart';
import '../widgets/custom_elevated_button_gradient.dart';


class AboutTheApps extends StatelessWidget {
  static const id = '/about-the-app';

   const AboutTheApps({Key key}) : super(key: key);

   




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black54,
          ),
          title: const Text(
            'About The Apps',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16.0,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.2,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      const Text(
                        "This STEKO Obesity checker is created in collaboration with Kulliyyah of ICT IIUM, Kulliyyah of Pharmacy IIUM and Dream AI Enterprise.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF4A4949),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Image.asset('assets/images/kict.png'),
                          
                          ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: Image.asset('assets/images/iium.png')),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  CustomElevatedButtonGradient(
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    height: 60.0,
                    borderRadius: BorderRadius.circular(4.0),
                    width: double.infinity,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

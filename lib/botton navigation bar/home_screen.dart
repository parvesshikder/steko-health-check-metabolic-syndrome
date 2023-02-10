import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steko_health_checker/constraints.dart';
import '../custom route/slide_right_route.dart';
import '../health status/health_status_update_screen.dart';
import '../metabolic syndrome/metabolic_syndrome.dart';
import '../widgets/blc_card.dart';
import '../widgets/bmi_overview.dart';
import '../widgets/home/hero_section_home_page.dart';
import 'profile/blood_pressure_and_siagar.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home-page';

  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final myUserId = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore firebaseFire = FirebaseFirestore.instance;

  String userName = '';
  String imageUrl = '';

  Future _getAllData() async {
    //user details
    if (myUserId != null) {
      await firebaseFire
          .collection('userData')
          .doc(myUserId)
          .get()
          .then((value) {
        userName = value.data()['name'] as String;
        imageUrl = value.data()['imageUrl'] as String;
      });
    }

    //blood Pressure
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
              future: _getAllData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    children: [
                      HeroSectionHomePage(
                          userName: userName, imageUrl: imageUrl),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: k30pxPaddingHorizontal,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: const Color(0xFFD9EAD3).withOpacity(0.7),
                              ),
                              height: 57.0,
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Update today\'s health status'),
                                  Container(
                                    width: 80,
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
                                            page: const HealthStatusScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Start',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: const Color(0xFFD9EAD3).withOpacity(0.7),
                              ),
                              height: 57.0,
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Self-Diagnose Metabolic Syndrome'),
                                  Container(
                                    width: 80,
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
                                            page: const MetabolicSyndrome(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Test',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: k30pxPaddingHorizontal,
                        child: const Text(
                          'Overview',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const BMIOverview(),
                      const BlcScreen(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const BloodPressureAndSugar(),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}

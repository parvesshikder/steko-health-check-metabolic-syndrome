// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:steko_health_checker/constraints.dart';
import '../widgets/custom_elevated_button_gradient.dart';
import 'insert_calories.dart';

class CaloriesIntake extends StatefulWidget {
  const CaloriesIntake({Key key}) : super(key: key);

  @override
  State<CaloriesIntake> createState() => _CaloriesIntakeState();
}

class _CaloriesIntakeState extends State<CaloriesIntake> {
  final myUserId = FirebaseAuth.instance.currentUser.uid;

  @override
  void initState() {
    super.initState();
    getData();
  }

  double totalCalories = 0;
  double mcalories = 0;
  double lcalories = 0;
  double dcalories = 0;
  bool loading = false;
  bool loading2 = false;

  final user = FirebaseAuth.instance.currentUser;

  Future<dynamic> getData() async {
    loading2 = true;
    FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
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

    // await firestoreInstance
    //     .collection("FoodListWithCalories")
    //     .get()
    //     .then((querySnapshot) => {
    //           // ignore: avoid_function_literals_in_foreach_calls
    //           if (querySnapshot.docs.isNotEmpty)
    //             {
    //               // ignore: avoid_function_literals_in_foreach_calls
    //               querySnapshot.docs.forEach((doc) {
    //                 setState(() {
    //                   _suggestions.add(doc.data()['name']);
    //                 });
    //               })
    //             }
    //           else
    //             {}
    //         });

    loading2 = false;
  }

  Future<bool> alertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Done'),
            content: const Text(' ✔ Added Successfully ',
                style: TextStyle(
                  color: Colors.green,
                )),
            actions: <Widget>[
              FlatButton(
                child: const Text('Ok'),
                onPressed: () {
                  setState(() {
                    getData();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<bool> redAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Failed'),
            content: const Text('☓ Invalid Entry ',
                style: TextStyle(
                  color: Colors.red,
                )),
            actions: <Widget>[
              FlatButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  // This will be displayed below the autocomplete field
  String _selectedFood;
  double caloriesIntake;
  String foodName;
  String mealTime;

  // This list holds all the suggestions
  final List<String> _suggestions = [
    'Nasi Goreng 388 Cal',
    'Nasi Lemak 400 Cal',
    'Pepperoni, beef, etc ( One slice) 155 Calories',
    'Fried chicken various portion (One piece) 290 Calories',
    'French fries (One cup,  small ) 290 Calories',
    'Sandwiches 71 Calories',
    'kaya/coconut bun (One)	219 Calories',
    'Plain roti canai & dhal (One pices and half plate) 359 Calories',
    'Roti telur & Dhal (One pices and half plate) 414 Calories', 
    'Mamak mee goreng	(One Plate) 660 Calories',
    'Prawn mee soup	(One bowl) 293 Calories',
    'Penang Laksa(One bowl) 436 Calories',
    'Oatmeal , Plain (One bowl) 225 Calories',
    'Nasi briyani + mutton (One Plate) 587 Calories',
    'Nasi minyak + beef rendang	(One Plate) 664 Calories',
    'Nasi Kerabu (One Plate) 360 Calories',
    'Fried Rice	(One Plate) 637 Calories',
    'Salad, raw	(One bowl) 100 Calories',
    'Plain soup ( meat or vegetable on bowl) 200 Calories',
    'Fried egg (One) 128 Calories',
    'Beef burger (regular) 317 Calories',
    'Cheese burger	(regular) 341 Cal',
    'Hot dog (one) 225 Cal',
    'Pepperoni, beef, etc	(one Slice) 155 Cal',
    'Fried chicken various portion (one piece) 290 Cal',
    

  ];

  String _groupValue = '';

  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  double percentage = 0;

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
              'Calories Intake',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loading2
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: CircularPercentIndicator(
                              radius: 50.0,
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
                                            '0',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ],
                                ),
                                height: 85,
                                width: 85,
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
                        ),
                      ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Add Meal Details',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Search Food',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue value) {
                          // When the field is empty
                          if (value.text.isEmpty) {
                            return [];
                          }

                          // The logic to find out which ones should appear
                          if(_suggestions != null){
                            return _suggestions.where((suggestion) => suggestion
                              .toLowerCase()
                              .contains(value.text.toLowerCase()));
                          }else{
                             ;
                          }
                          
                        },
                        onSelected: (value) {
                          setState(() {
                            _selectedFood = value;

                            String caloriesIntakeFood =
                                _selectedFood.replaceAll(RegExp(r'[^0-9]'), '');

                            caloriesIntake = double.parse(caloriesIntakeFood);
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: _selectedFood ?? 'Food Name',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 61, 61, 61),
                            fontSize: 15.0,
                          ),
                          prefixIcon:
                              const Icon(Icons.restaurant, color: Colors.green),
                          suffixIcon: Container(
                            width: 100,
                            child: Center(
                              child: caloriesIntake == null
                                  ? const Text(
                                      '00 Calories',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )
                                  : Text(
                                      '$caloriesIntake Calories',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                            ),
                            decoration: BoxDecoration(
                              gradient: kGreenGradientColor,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Breakfast'),
                            leading: Radio(
                                activeColor: Colors.green,
                                value: 'Breakfast',
                                groupValue: _groupValue,
                                onChanged: (value) {
                                  checkRadio(value as String);
                                }),
                          ),
                          ListTile(
                            title: const Text('Lunch'),
                            leading: Radio(
                                activeColor: Colors.green,
                                value: 'Lunch',
                                groupValue: _groupValue,
                                onChanged: (value) {
                                  checkRadio(value as String);
                                }),
                          ),
                          ListTile(
                            title: const Text('Dinner'),
                            leading: Radio(
                                activeColor: Colors.green,
                                value: 'Dinner',
                                groupValue: _groupValue,
                                onChanged: (value) {
                                  checkRadio(value as String);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
                loading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomElevatedButtonGradient(
                        width: double.infinity,
                        onPressed: () async {
                          if (caloriesIntake != null && _groupValue != null) {
                            setState(() {
                              loading = true;
                            });

                            await InsertCaloriesData().inserCaloriesData(
                              totalCalories: caloriesIntake,
                              userId: myUserId,
                              mealTime: _groupValue,
                            );

                            // greenAlertDialog(context);

                            setState(() {
                              loading = false;
                            });

                            alertDialog(context);
                          } else {
                            redAlertDialog(context);
                          }
                        },
                        borderRadius: BorderRadius.circular(4.0),
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        height: 62.0,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

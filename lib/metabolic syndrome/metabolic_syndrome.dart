import 'package:flutter/material.dart';
import 'package:steko_health_checker/metabolic%20syndrome/question.dart';
import 'package:steko_health_checker/metabolic%20syndrome/result.dart';

import '../constraints.dart';
import '../health_quiz/ui/shared/color.dart';
import '../widgets/custom_elevated_button_gradient.dart';
import 'ms_question.dart';

class MetabolicSyndrome extends StatefulWidget {
  const MetabolicSyndrome({Key key}) : super(key: key);

  @override
  State<MetabolicSyndrome> createState() => _MetabolicSyndromeState();
}

class _MetabolicSyndromeState extends State<MetabolicSyndrome> {
  bool quiz = false;
  bool diabetec;
  MSQuestion question = MSQuestion();
  int count = 0;

  String _selectedItemDiabetics;
  String _selectedItemDiabeticsPoint;
  String _treatmentforHPT;
  String _treatmentforlowHDL;
  String _bP13085;
  String _gender;
  String _hDLcholesterol1Point0;
  String _hDLcholesterol1Point3;
  String _forhighTriglycerides;
  String _Triglycerides17;
  String _wc90;
  String _wc80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Self-Diagnose Metabolic Syndrome',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'What is Metabolic Syndrome?',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Metabolic syndrome is a group of five conditions that can lead to heart disease , diabetes , stroke and other health problems . It is diagnosed when someone had three or more of these risk factors :',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/images/1.png'),
              const SizedBox(
                height: 20,
              ),
              CustomElevatedButtonGradient(
                width: double.infinity,
                onPressed: () {
                  setState(() {
                    quiz = true;
                  });
                },
                borderRadius: BorderRadius.circular(50.0),
                child: const Text(
                  'Test Metabolic Syndrome',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                height: 40.0,
              ),
              const SizedBox(
                height: 20,
              ),
              quiz
                  ? Column(
                      children: [
                        QuizQuestion(
                          question: question.getQuestionA(0),
                          btn1: Radio<String>(
                            value: 'yes',
                            activeColor: Colors.white,
                            groupValue: _selectedItemDiabetics,
                            onChanged: (value) {
                              setState(() {
                                _selectedItemDiabetics = value;
                                _selectedItemDiabeticsPoint = '';
                              });
                            },
                          ),
                          btn2: Radio<String>(
                            value: 'no',
                            activeColor: Colors.white,
                            groupValue: _selectedItemDiabetics,
                            onChanged: (value) {
                              setState(() {
                                _selectedItemDiabetics = value;
                              });
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //
                        Visibility(
                          visible:
                              _selectedItemDiabetics == 'no' ? true : false,
                          child: QuizQuestion(
                            question: question.getQuestionA(1),
                            btn1: Radio<String>(
                              value: 'yes',
                              activeColor: Colors.white,
                              groupValue: _selectedItemDiabeticsPoint,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItemDiabeticsPoint = value;
                                });
                              },
                            ),
                            btn2: Radio<String>(
                              value: 'no',
                              activeColor: Colors.white,
                              groupValue: _selectedItemDiabeticsPoint,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItemDiabeticsPoint = value;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        QuizQuestion(
                          question: question.getQuestionB(0),
                          btn1: Radio<String>(
                            value: 'yes',
                            activeColor: Colors.white,
                            groupValue: _treatmentforHPT,
                            onChanged: (value) {
                              setState(() {
                                _treatmentforHPT = value;
                                _bP13085 = '';
                              });
                            },
                          ),
                          btn2: Radio<String>(
                            value: 'no',
                            activeColor: Colors.white,
                            groupValue: _treatmentforHPT,
                            onChanged: (value) {
                              setState(() {
                                _treatmentforHPT = value;
                              });
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //
                        Visibility(
                          visible: _treatmentforHPT == 'no' ? true : false,
                          child: QuizQuestion(
                            question: question.getQuestionB(1),
                            btn1: Radio<String>(
                              value: 'yes',
                              activeColor: Colors.white,
                              groupValue: _bP13085,
                              onChanged: (value) {
                                setState(() {
                                  _bP13085 = value;
                                });
                              },
                            ),
                            btn2: Radio<String>(
                              value: 'no',
                              activeColor: Colors.white,
                              groupValue: _bP13085,
                              onChanged: (value) {
                                setState(() {
                                  _bP13085 = value;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        QuizQuestion(
                          question: question.getQuestionC(0),
                          btn1: Radio<String>(
                            value: 'yes',
                            activeColor: Colors.white,
                            groupValue: _treatmentforlowHDL,
                            onChanged: (value) {
                              setState(() {
                                _treatmentforlowHDL = value;
                              });
                            },
                          ),
                          btn2: Radio<String>(
                            value: 'no',
                            activeColor: Colors.white,
                            groupValue: _treatmentforlowHDL,
                            onChanged: (value) {
                              setState(() {
                                _treatmentforlowHDL = value;
                              });
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Visibility(
                          visible: _treatmentforlowHDL == 'no' ? true : false,
                          child: QuizQuestion(
                            text1: 'Male',
                            text2: 'Female',
                            question: question.getQuestionC(1),
                            btn1: Radio<String>(
                              value: 'm',
                              activeColor: Colors.white,
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            btn2: Radio<String>(
                              value: 'f',
                              activeColor: Colors.white,
                              groupValue: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Visibility(
                          visible: _gender == 'm' ? true : false,
                          child: QuizQuestion(
                            question: question.getQuestionC(2),
                            btn1: Radio<String>(
                              value: 'yes',
                              activeColor: Colors.white,
                              groupValue: _hDLcholesterol1Point0,
                              onChanged: (value) {
                                setState(() {
                                  _hDLcholesterol1Point0 = value;
                                  _hDLcholesterol1Point3 = '';
                                });
                              },
                            ),
                            btn2: Radio<String>(
                              value: 'no',
                              activeColor: Colors.white,
                              groupValue: _hDLcholesterol1Point0,
                              onChanged: (value) {
                                setState(() {
                                  _hDLcholesterol1Point0 = value;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Visibility(
                          visible: _gender == 'f' ? true : false,
                          child: QuizQuestion(
                            question: question.getQuestionC(3),
                            btn1: Radio<String>(
                              value: 'yes',
                              activeColor: Colors.white,
                              groupValue: _hDLcholesterol1Point3,
                              onChanged: (value) {
                                setState(() {
                                  _hDLcholesterol1Point3 = value;
                                  _hDLcholesterol1Point0 = '';
                                });
                              },
                            ),
                            btn2: Radio<String>(
                              value: 'no',
                              activeColor: Colors.white,
                              groupValue: _hDLcholesterol1Point3,
                              onChanged: (value) {
                                setState(() {
                                  _hDLcholesterol1Point3 = value;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        QuizQuestion(
                          question: question.getQuestionD(0),
                          btn1: Radio<String>(
                            value: 'yes',
                            activeColor: Colors.white,
                            groupValue: _forhighTriglycerides,
                            onChanged: (value) {
                              setState(() {
                                _forhighTriglycerides = value;
                              });
                            },
                          ),
                          btn2: Radio<String>(
                            value: 'no',
                            activeColor: Colors.white,
                            groupValue: _forhighTriglycerides,
                            onChanged: (value) {
                              setState(() {
                                _forhighTriglycerides = value;
                              });
                            },
                          ),
                        ),

                        SizedBox(height: 10),

                        Visibility(
                          visible: _forhighTriglycerides == 'no' ? true : false,
                          child: QuizQuestion(
                            question: question.getQuestionD(1),
                            btn1: Radio<String>(
                              value: 'yes',
                              activeColor: Colors.white,
                              groupValue: _Triglycerides17,
                              onChanged: (value) {
                                setState(() {
                                  _Triglycerides17 = value;
                                });
                              },
                            ),
                            btn2: Radio<String>(
                              value: 'no',
                              activeColor: Colors.white,
                              groupValue: _Triglycerides17,
                              onChanged: (value) {
                                setState(() {
                                  _Triglycerides17 = value;
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        Visibility(
                          visible: _gender == 'male' ? true : false,
                          child: QuizQuestion(
                            question: question.getQuestionE(0),
                            btn1: Radio<String>(
                              value: 'yes',
                              activeColor: Colors.white,
                              groupValue: _wc90,
                              onChanged: (value) {
                                setState(() {
                                  _wc90 = value;
                                });
                              },
                            ),
                            btn2: Radio<String>(
                              value: 'no',
                              activeColor: Colors.white,
                              groupValue: _wc90,
                              onChanged: (value) {
                                setState(() {
                                  _wc90 = value;
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Visibility(
                          visible: _gender == 'female' ? true : false,
                          child: QuizQuestion(
                            question: question.getQuestionE(1),
                            btn1: Radio<String>(
                              value: 'yes',
                              activeColor: Colors.white,
                              groupValue: _wc90,
                              onChanged: (value) {
                                setState(() {
                                  _wc90 = value;
                                });
                              },
                            ),
                            btn2: Radio<String>(
                              value: 'no',
                              activeColor: Colors.white,
                              groupValue: _wc90,
                              onChanged: (value) {
                                setState(() {
                                  _wc90 = value;
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_selectedItemDiabetics == 'yes') {
                                count++;
                              }
                              if (_selectedItemDiabeticsPoint == 'yes') {
                                count++;
                              }
                              if (_treatmentforHPT == 'yes') {
                                count++;
                              }
                              if (_treatmentforlowHDL == 'yes') {
                                count++;
                              }
                              if (_bP13085 == 'yes') {
                                count++;
                              }
                              if (_hDLcholesterol1Point0 == 'yes') {
                                count++;
                              }
                              if (_hDLcholesterol1Point3 == 'yes') {
                                count++;
                              }
                              if (_forhighTriglycerides == 'yes') {
                                count++;
                              }
                              if (_Triglycerides17 == 'yes') {
                                count++;
                              }
                              if (_wc90 == 'yes') {
                                count++;
                              }
                              if (_wc80 == 'yes') {
                                count++;
                              }

                              if (_selectedItemDiabetics != null &&
                                  _treatmentforHPT != null &&
                                  _treatmentforlowHDL != null &&
                                  _forhighTriglycerides != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ResultScreenMS(count: count),
                                    ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Select all the fields'),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.pripmaryColor,
                              padding: const EdgeInsets.all(18.0),
                            ),
                            child: const Text(
                              "Test",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}

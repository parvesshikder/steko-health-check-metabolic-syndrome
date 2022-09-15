import 'dart:math';

class CalculateBMI {
  CalculateBMI({this.height, this.weight});

  final double weight;
  final double height;

  double _bmi;

  double calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toDouble();
  }

  String getResult() {

    if(_bmi < 16){
      return 'Sever Thinness';
    }
    else if (_bmi >= 16 && _bmi <= 17) {
      return 'Moderate Thinness';
    }
    else if (_bmi > 17 && _bmi <= 18.4) {
      return 'Mild Thinness';
    }
    else if (_bmi >= 18.5 && _bmi <= 25) {
      return 'Normal';
    }
    else if (_bmi >= 25.1 && _bmi <= 30) {
      return 'Overweight';
    }
    else if (_bmi >= 30.1 && _bmi <= 35) {
      return 'Obese Class I';
    }
    else if (_bmi >= 35.1 && _bmi <= 40) {
      return 'Obese Class II';
    }else if (_bmi >= 40.1 ) {
      return 'Obese Class III';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more and take a super healthy diet';
    } else if (_bmi >= 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more.';
    }
  }
}

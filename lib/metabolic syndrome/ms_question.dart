class MSQuestion {
  final List _questionsA = [
    'Are you diabetec?',
    'Are your glucose ≥ 5.6 mmol/L?',
  ];

  final List _questionsB = [
    'Do you receive treatment for HPT?',
    'Are your BP ≥ 130/85 mmHg ?',
  ];

  final List _questionsC = [
    'Do you receive treatment for low HDL-cholesterol?',
    'Select your Gender?',
    'Are your HDL cholesterol < 1.0mmol/L (40mg /dL)?',
    'Are your HDL cholesterol < 1.3mmol/L (50mg /dL)?',
  ];
  final List _questionsD = [
    'Do you receive treatment for high Triglycerides?',
    'Are your Triglycerides ≥ 1.7 mmol/L (150mg/dL)?',
  ];

  final List _questionsE = [
    'Are your abdominal obesity waist circumference ≥ 90cm?',
    'Are your abdominal obesity waist circumference ≥ 80cm?',
  ];

  String getQuestionA(int index) {
    return _questionsA[index];
  }

  int getIndexA() {
    return _questionsA.length;
  }

  String getQuestionE(int index) {
    return _questionsE[index];
  }

  int getIndexE() {
    return _questionsE.length;
  }

  String getQuestionB(int index) {
    return _questionsB[index];
  }

  int getIndexB() {
    return _questionsB.length;
  }

  String getQuestionC(int index) {
    return _questionsC[index];
  }

  int getIndexC() {
    return _questionsC.length;
  }

  String getQuestionD(int index) {
    return _questionsD[index];
  }

  int getIndexD() {
    return _questionsD.length;
  }
}

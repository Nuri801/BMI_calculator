import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({required this.height, required this.weight});

  final double height;
  final double weight;

  late double _bmi;

  String calculatorBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'Your BMI is above average, try to exercise more!';
    } else if (_bmi > 18.5) {
      return 'Your BMI is normal, keep up the healthy lifestyle!';
    } else {
      return 'Your BMI is under average, try to eat more!';
    }
  }
}
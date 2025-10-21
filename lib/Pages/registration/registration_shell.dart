import 'package:flutter/material.dart';
import 'step_one_page.dart';
import 'step_two_page.dart';
import 'step_three_page.dart';
import 'step_four_page.dart';

class RegistrationShell extends StatefulWidget {
  const RegistrationShell({super.key});

  @override
  State<RegistrationShell> createState() => _RegistrationShellState();
}

class _RegistrationShellState extends State<RegistrationShell> {
  int currentStep = 0;

  final List<Widget> steps = const [
    StepOnePage(),
    StepTwoPage(),
    StepThreePage(),
    StepFourPage(),
  ];

  void nextStep() {
    if (currentStep < steps.length - 1) {
      setState(() => currentStep++);
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: steps[currentStep],
    );
  }
}

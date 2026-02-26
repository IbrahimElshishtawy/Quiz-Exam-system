import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_input.dart';
import '../../../../core/theme/app_colors.dart';

class ExamBuilderView extends StatefulWidget {
  const ExamBuilderView({super.key});

  @override
  State<ExamBuilderView> createState() => _ExamBuilderViewState();
}

class _ExamBuilderViewState extends State<ExamBuilderView> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Exam')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 3) {
            setState(() => _currentStep++);
          } else {
            Get.back();
            Get.snackbar('Success', 'Exam created successfully', backgroundColor: AppColors.success, colorText: Colors.white);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          } else {
            Get.back();
          }
        },
        steps: [
          Step(
            title: const Text('Basics'),
            isActive: _currentStep >= 0,
            content: Column(
              children: [
                const AppInput(label: 'Exam Title', hint: 'e.g. Midterm Computer Science'),
                const SizedBox(height: 16),
                const AppInput(label: 'Description', hint: 'e.g. Topics covered: Chapter 1-5'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: const AppInput(label: 'Start Date', hint: 'YYYY-MM-DD')),
                    const SizedBox(width: 16),
                    Expanded(child: const AppInput(label: 'End Date', hint: 'YYYY-MM-DD')),
                  ],
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Questions'),
            isActive: _currentStep >= 1,
            content: Column(
              children: [
                const Text('Choose Question Bank source or create custom questions.'),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Add Questions from Bank'),
                ),
                const SizedBox(height: 16),
                const Text('Selected: 20 Questions (12 MCQ, 8 True/False)'),
              ],
            ),
          ),
          Step(
            title: const Text('Rules'),
            isActive: _currentStep >= 2,
            content: Column(
              children: [
                _ruleSwitch('Duration', '60 Minutes'),
                _ruleSwitch('Shuffle Questions', 'Enabled'),
                _ruleSwitch('Show Results Immediately', 'Disabled'),
                _ruleSwitch('Cooldown Period', 'None'),
              ],
            ),
          ),
          Step(
            title: const Text('Security'),
            isActive: _currentStep >= 3,
            content: Column(
              children: [
                _ruleSwitch('One Device Policy', 'Enabled'),
                _ruleSwitch('Proctoring Level', 'High (Focus detection + Blur)'),
                _ruleSwitch('Watermark', 'Enabled'),
                const SizedBox(height: 16),
                const Text('Review carefully before publishing. All changes are logged.', style: TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ruleSwitch(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

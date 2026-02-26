// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_card.dart';
import '../../../../routes/app_routes.dart';

class ExamDetailsView extends StatelessWidget {
  const ExamDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exam Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Final Computer Science Exam',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  const Text('Room: CS-201 • Instructor: Dr. Ahmed'),
                  const Divider(height: 32),
                  _infoRow(
                    context,
                    Icons.timer_outlined,
                    'Duration',
                    '60 Minutes',
                  ),
                  _infoRow(
                    context,
                    Icons.help_outline,
                    'Questions',
                    '40 Questions',
                  ),
                  _infoRow(
                    context,
                    Icons.check_circle_outline,
                    'Passing Score',
                    '50%',
                  ),
                  _infoRow(
                    context,
                    Icons.refresh_outlined,
                    'Attempts',
                    '1 Attempt',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Anti-Cheat Requirements',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            AppCard(
              color: Colors.red.withOpacity(0.05),
              child: Column(
                children: [
                  _warningRow(
                    context,
                    'Do not leave the application during the exam.',
                  ),
                  _warningRow(
                    context,
                    'Screen recording or screenshots are strictly prohibited.',
                  ),
                  _warningRow(
                    context,
                    'The exam will automatically submit if time runs out.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Checkbox(value: true, onChanged: (v) {}),
                const Expanded(
                  child: Text(
                    'I understand the rules and I am ready to start the exam.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            AppButton(
              text: 'Start Exam',
              onPressed: () => Get.toNamed(Routes.EXAM_PLAYER),
              icon: Icons.play_arrow_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _warningRow(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded, size: 18, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

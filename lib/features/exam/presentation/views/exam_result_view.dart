import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/app_button.dart';
import '../../../../core/components/app_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';

class ExamResultView extends StatelessWidget {
  const ExamResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              const Icon(Icons.check_circle_rounded, size: 80, color: AppColors.success),
              const SizedBox(height: 24),
              Text('Exam Submitted!', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              const Text('Your exam has been successfully received.'),
              const SizedBox(height: 48),
              AppCard(
                child: Column(
                  children: [
                    _resultRow(context, 'Total Score', '85/100', color: AppColors.primary),
                    const Divider(height: 32),
                    _resultRow(context, 'Correct Answers', '34'),
                    _resultRow(context, 'Incorrect Answers', '6'),
                    _resultRow(context, 'Time Spent', '42m 12s'),
                  ],
                ),
              ),
              const Spacer(),
              AppButton(
                text: 'Back to Dashboard',
                onPressed: () => Get.offAllNamed(Routes.STUDENT_DASHBOARD),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text('Review Answers'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultRow(BuildContext context, String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

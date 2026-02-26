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
    // Demo values (اربطها بعدين ببيانات الكنترولر)
    const int score = 85;
    const int maxScore = 100;
    const int correct = 34;
    const int incorrect = 6;
    const String timeSpent = '42m 12s';

    final double pct = score / maxScore; // 0..1
    final bool passed = pct >= 0.5;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),

                  // Header
                  AppCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _StatusIcon(passed: passed),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Exam Submitted!',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Your exam has been successfully received.',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.black54),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: (passed
                                          ? AppColors.success
                                          : AppColors.warning)
                                      .withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  passed
                                      ? 'Status: Passed'
                                      : 'Status: Not Passed',
                                  style: TextStyle(
                                    color:
                                        passed
                                            ? AppColors.success
                                            : AppColors.warning,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Score ring + main score
                  AppCard(
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: LayoutBuilder(
                        builder: (context, c) {
                          final stacked = c.maxWidth < 520;

                          final ring = _ScoreRing(
                            percent: pct,
                            centerText: '$score/$maxScore',
                            subtitle: 'Total Score',
                          );

                          final details = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ResultTile(
                                icon: Icons.check_circle_outline,
                                label: 'Correct Answers',
                                value: '$correct',
                                valueColor: AppColors.success,
                              ),
                              const SizedBox(height: 10),
                              _ResultTile(
                                icon: Icons.cancel_outlined,
                                label: 'Incorrect Answers',
                                value: '$incorrect',
                                valueColor: AppColors.error,
                              ),
                              const SizedBox(height: 10),
                              _ResultTile(
                                icon: Icons.timer_outlined,
                                label: 'Time Spent',
                                value: timeSpent,
                                valueColor: AppColors.primary,
                              ),
                            ],
                          );

                          return stacked
                              ? Column(
                                children: [
                                  ring,
                                  const SizedBox(height: 14),
                                  details,
                                ],
                              )
                              : Row(
                                children: [
                                  Expanded(child: ring),
                                  const SizedBox(width: 12),
                                  Expanded(child: details),
                                ],
                              );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Actions
                  AppButton(
                    text: 'Back to Dashboard',
                    onPressed: () => Get.offAllNamed(Routes.STUDENT_DASHBOARD),
                    icon: Icons.home_rounded,
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: اربطه بصفحة Review Answers
                      Get.snackbar(
                        'Coming soon',
                        'Review Answers screen is not wired yet.',
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                      );
                    },
                    icon: const Icon(Icons.visibility_outlined),
                    label: const Text('Review Answers'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text(
                    'Tip: You can review your answers to understand mistakes and improve.',
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------- UI Helpers ----------

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.passed});
  final bool passed;

  @override
  Widget build(BuildContext context) {
    final color = passed ? AppColors.success : AppColors.warning;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        passed ? Icons.check_circle_rounded : Icons.info_rounded,
        color: color,
        size: 28,
      ),
    );
  }
}

class _ScoreRing extends StatelessWidget {
  const _ScoreRing({
    required this.percent,
    required this.centerText,
    required this.subtitle,
  });

  final double percent; // 0..1
  final String centerText;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final clamped = percent.clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: clamped,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.withOpacity(0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      clamped >= 0.5 ? AppColors.success : AppColors.warning,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      centerText,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${(clamped * 100).round()}%',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: valueColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: valueColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

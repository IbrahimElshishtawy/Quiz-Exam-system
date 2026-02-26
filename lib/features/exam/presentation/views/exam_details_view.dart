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
    final agreed = false.obs;

    return Scaffold(
      appBar: AppBar(title: const Text('Exam Details')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderCard(),

                  const SizedBox(height: 16),

                  // Quick stats chips (responsive)
                  LayoutBuilder(
                    builder: (context, c) {
                      final isNarrow = c.maxWidth < 420;
                      final children = [
                        _StatChip(
                          icon: Icons.timer_outlined,
                          label: 'Duration',
                          value: '60 min',
                        ),
                        _StatChip(
                          icon: Icons.help_outline,
                          label: 'Questions',
                          value: '40',
                        ),
                        _StatChip(
                          icon: Icons.check_circle_outline,
                          label: 'Passing',
                          value: '50%',
                        ),
                        _StatChip(
                          icon: Icons.refresh_outlined,
                          label: 'Attempts',
                          value: '1',
                        ),
                      ];

                      return isNarrow
                          ? Column(
                            children: [
                              for (int i = 0; i < children.length; i++) ...[
                                SizedBox(
                                  width: double.infinity,
                                  child: children[i],
                                ),
                                if (i != children.length - 1)
                                  const SizedBox(height: 10),
                              ],
                            ],
                          )
                          : Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: children,
                          );
                    },
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
                      children: const [
                        _WarningRow(
                          'Do not leave the application during the exam.',
                        ),
                        _WarningRow(
                          'Screen recording or screenshots are strictly prohibited.',
                        ),
                        _WarningRow(
                          'The exam will automatically submit if time runs out.',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Agreement
                  Obx(
                    () => AppCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: agreed.value,
                            onChanged: (v) => agreed.value = v ?? false,
                          ),
                          const SizedBox(width: 6),
                          const Expanded(
                            child: Text(
                              'I understand the rules and I am ready to start the exam.',
                              style: TextStyle(height: 1.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Start button (disabled until agreed)
                  Obx(
                    () => Opacity(
                      opacity: agreed.value ? 1 : 0.6,
                      child: IgnorePointer(
                        ignoring: !agreed.value,
                        child: AppButton(
                          text: 'Start Exam',
                          onPressed: () => Get.toNamed(Routes.EXAM_PLAYER),
                          icon: Icons.play_arrow_rounded,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Optional helper text
                  Text(
                    'Tip: Make sure your battery is charged and your internet connection is stable.',
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

/// ---------------- UI Parts ----------------

class _HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.school_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Final Computer Science Exam',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                const Text('Room: CS-201 • Instructor: Dr. Ahmed'),
                const SizedBox(height: 10),
                Divider(color: Colors.grey.shade300, height: 18),
                const SizedBox(height: 4),
                Text(
                  'Please review the rules below before starting.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _WarningRow extends StatelessWidget {
  const _WarningRow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded, size: 18, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.red,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

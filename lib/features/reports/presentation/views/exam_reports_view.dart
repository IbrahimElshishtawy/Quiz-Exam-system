// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/app_card.dart';
import '../../../../core/components/app_badge.dart';
import '../../../../core/theme/app_colors.dart';

class ExamMonitorView extends StatelessWidget {
  const ExamMonitorView({super.key});

  @override
  Widget build(BuildContext context) {
    final query = ''.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-time Monitor'),
        actions: [
          IconButton(
            onPressed: () => _showFilterSheet(context),
            icon: const Icon(Icons.filter_list_rounded),
            tooltip: 'Filter',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: _SearchField(onChanged: (v) => query.value = v.trim()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
              child: _buildSummaryCards(context),
            ),
            Expanded(
              child: Obx(() {
                // Demo list
                final items =
                    List.generate(15, (i) => i)
                        .where(
                          (i) =>
                              query.value.isEmpty ||
                              'Student ${1001 + i}'.toLowerCase().contains(
                                query.value.toLowerCase(),
                              ),
                        )
                        .toList();

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  itemCount: items.length,
                  itemBuilder: (context, idx) {
                    final index = items[idx];
                    final isRisk = index % 4 == 0;
                    final riskScore =
                        isRisk ? 0.82 : (0.15 + (index % 3) * 0.12);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _StudentSessionCard(
                        studentId: 1001 + index,
                        isRisk: isRisk,
                        lastActive: '2 min ago',
                        progress: 0.35 + (index % 5) * 0.12,
                        riskScore: riskScore.clamp(0.0, 1.0),
                        onTap:
                            () => _showSessionDetails(context, isRisk: isRisk),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cardWidth = (c.maxWidth - 12) / 2; // 2 columns on most phones

        final cards = [
          _SummaryCard(
            label: 'In Progress',
            value: '124',
            icon: Icons.play_circle_outline,
            color: AppColors.primary,
          ),
          _SummaryCard(
            label: 'Submitted',
            value: '12',
            icon: Icons.check_circle_outline,
            color: AppColors.success,
          ),
          _SummaryCard(
            label: 'High Risk',
            value: '4',
            icon: Icons.warning_amber_rounded,
            color: AppColors.error,
          ),
          _SummaryCard(
            label: 'Warnings',
            value: '9',
            icon: Icons.report_outlined,
            color: AppColors.warning,
          ),
        ];

        // لو الشاشة واسعة، نخليها 4 في صف واحد
        final isWide = c.maxWidth >= 720;

        if (isWide) {
          return Row(
            children: [
              for (int i = 0; i < cards.length; i++) ...[
                Expanded(child: cards[i]),
                if (i != cards.length - 1) const SizedBox(width: 12),
              ],
            ],
          );
        }

        // موبايل: 2x2
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              cards.map((w) => SizedBox(width: cardWidth, child: w)).toList(),
        );
      },
    );
  }

  void _showFilterSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filters',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              _FilterTile(
                icon: Icons.warning_amber_rounded,
                title: 'Show high risk only',
                subtitle: 'Only students with risk detected',
                onTap: () => Get.back(),
              ),
              _FilterTile(
                icon: Icons.check_circle_outline,
                title: 'Show healthy only',
                subtitle: 'Hide warnings and risks',
                onTap: () => Get.back(),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSessionDetails(BuildContext context, {required bool isRisk}) {
    Get.bottomSheet(
      DraggableScrollableSheet(
        initialChildSize: 0.62,
        maxChildSize: 0.92,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Session Timeline',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      AppBadge(
                        label: isRisk ? 'Risk Detected' : 'Healthy',
                        color: isRisk ? AppColors.error : AppColors.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Live events and proctoring signals',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                  ),
                  const SizedBox(height: 14),

                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: const [
                        _TimelineItem(
                          time: '10:00 AM',
                          action: 'Exam Started',
                          icon: Icons.play_arrow_rounded,
                          color: AppColors.success,
                        ),
                        _TimelineItem(
                          time: '10:15 AM',
                          action: 'Focus Lost (Left Application)',
                          icon: Icons.warning_amber_rounded,
                          color: AppColors.warning,
                        ),
                        _TimelineItem(
                          time: '10:17 AM',
                          action: 'Focus Regained',
                          icon: Icons.check_circle_outline,
                          color: AppColors.success,
                        ),
                        _TimelineItem(
                          time: '10:25 AM',
                          action: 'Screen Recording Detected',
                          icon: Icons.error_outline,
                          color: AppColors.error,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('Close'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                            Get.snackbar(
                              'Action',
                              'Invalidate action (demo)',
                              backgroundColor: AppColors.error,
                              colorText: Colors.white,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('Invalidate Exam'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }
}

/// ---------------- UI Components ----------------

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search student...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudentSessionCard extends StatelessWidget {
  const _StudentSessionCard({
    required this.studentId,
    required this.isRisk,
    required this.lastActive,
    required this.progress,
    required this.riskScore,
    required this.onTap,
  });

  final int studentId;
  final bool isRisk;
  final String lastActive;
  final double progress; // 0..1
  final double riskScore; // 0..1
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final badgeColor = isRisk ? AppColors.error : AppColors.success;
    final badgeLabel = isRisk ? 'Risk Detected' : 'Healthy';

    return AppCard(
      onTap: onTap,
      color: isRisk ? AppColors.error.withOpacity(0.05) : null,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                studentId.toString().substring(studentId.toString().length - 2),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Student $studentId',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Last active: $lastActive',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),

                  // progress + risk
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: progress.clamp(0.0, 1.0),
                      minHeight: 8,
                      backgroundColor: Colors.grey.withOpacity(0.12),
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Progress ${(progress * 100).round()}% • Risk ${(riskScore * 100).round()}%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),
            AppBadge(label: badgeLabel, color: badgeColor),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }
}

class _FilterTile extends StatelessWidget {
  const _FilterTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.time,
    required this.action,
    required this.icon,
    required this.color,
  });

  final String time;
  final String action;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    action,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

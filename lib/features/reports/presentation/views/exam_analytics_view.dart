// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/components/app_card.dart';

class ExamAnalyticsView extends StatelessWidget {
  const ExamAnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Analytics'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: export PDF/CSV
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Export coming soon')),
              );
            },
            icon: const Icon(Icons.file_download_outlined),
            tooltip: 'Export',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _OverviewSection(),
                  const SizedBox(height: 22),

                  _SectionHeader(
                    title: 'Score Distribution',
                    subtitle: 'How students performed across score ranges',
                    icon: Icons.stacked_bar_chart_outlined,
                  ),
                  const SizedBox(height: 12),
                  _ScoreDistributionChart(),
                  const SizedBox(height: 22),

                  _SectionHeader(
                    title: 'Question Difficulty Index',
                    subtitle: 'Higher fail rate means more difficult questions',
                    icon: Icons.insights_outlined,
                  ),
                  const SizedBox(height: 12),
                  _QuestionDifficultyList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------------- Sections ----------------

class _OverviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final stacked = c.maxWidth < 520;

        final cards = [
          _ReportStatCard(
            label: 'Pass Rate',
            value: '84%',
            icon: Icons.check_circle_outline,
            color: AppColors.success,
            helper: 'Students who passed',
          ),
          _ReportStatCard(
            label: 'Avg Score',
            value: '72.5',
            icon: Icons.bar_chart_outlined,
            color: AppColors.primary,
            helper: 'Mean score',
          ),
          _ReportStatCard(
            label: 'Participants',
            value: '120',
            icon: Icons.groups_outlined,
            color: Colors.deepPurple,
            helper: 'Total students',
          ),
          _ReportStatCard(
            label: 'Median',
            value: '74',
            icon: Icons.show_chart_outlined,
            color: Colors.teal,
            helper: 'Middle score',
          ),
        ];

        return stacked
            ? Column(
              children: [
                for (int i = 0; i < cards.length; i++) ...[
                  cards[i],
                  if (i != cards.length - 1) const SizedBox(height: 12),
                ],
              ],
            )
            : Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  cards
                      .map(
                        (w) => SizedBox(
                          width: (c.maxWidth - 12) / 2, // 2 columns
                          child: w,
                        ),
                      )
                      .toList(),
            );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// ---------------- Widgets ----------------

class _ReportStatCard extends StatelessWidget {
  const _ReportStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.helper,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String helper;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
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
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    helper,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black54),
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

class _ScoreDistributionChart extends StatelessWidget {
  // Demo data
  final List<_BarData> data = const [
    _BarData(label: '0-20', value: 0.2),
    _BarData(label: '21-40', value: 0.4),
    _BarData(label: '41-60', value: 0.8),
    _BarData(label: '61-80', value: 1.0, primary: true),
    _BarData(label: '81-100', value: 0.6),
  ];

  const _ScoreDistributionChart();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Students per score bucket',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 220,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Y-axis hint
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'High',
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                        Text(
                          'Med',
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                        Text(
                          'Low',
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, c) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children:
                              data
                                  .map(
                                    (e) => _Bar(
                                      label: e.label,
                                      heightFactor: e.value,
                                      isPrimary: e.primary,
                                    ),
                                  )
                                  .toList(),
                        );
                      },
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

class _Bar extends StatelessWidget {
  const _Bar({
    required this.label,
    required this.heightFactor,
    required this.isPrimary,
  });

  final String label;
  final double heightFactor;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final barColor =
        isPrimary ? AppColors.primary : AppColors.primary.withOpacity(0.35);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 34,
          height: 160 * heightFactor.clamp(0.0, 1.0),
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _QuestionDifficultyList extends StatelessWidget {
  // Demo fail rates
  final List<double> difficulties = const [0.1, 0.4, 0.7, 0.3, 0.9];

  const _QuestionDifficultyList();

  String _tag(double v) {
    if (v >= 0.75) return 'Hard';
    if (v >= 0.45) return 'Medium';
    return 'Easy';
  }

  Color _tagColor(double v) {
    if (v >= 0.75) return AppColors.error;
    if (v >= 0.45) return AppColors.warning;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(difficulties.length, (i) {
        final v = difficulties[i];
        final tag = _tag(v);
        final tagColor = _tagColor(v);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: tagColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(Icons.help_outline, color: tagColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question #${i + 1}',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: v,
                            minHeight: 10,
                            backgroundColor: Colors.grey.withOpacity(0.12),
                            color:
                                v > 0.7 ? AppColors.error : AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${(v * 100).toInt()}% Fail Rate',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: tagColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: tagColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _BarData {
  final String label;
  final double value;
  final bool primary;

  const _BarData({
    required this.label,
    required this.value,
    this.primary = false,
  });
}

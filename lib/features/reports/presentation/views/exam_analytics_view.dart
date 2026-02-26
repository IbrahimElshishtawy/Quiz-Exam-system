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
            onPressed: () {},
            icon: const Icon(Icons.file_download_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewCards(context),
            const SizedBox(height: 32),
            Text(
              'Score Distribution',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _mockChart(context),
            const SizedBox(height: 32),
            Text(
              'Question Difficulty Index',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildQuestionDifficultyList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _reportStatCard(
            context,
            'Pass Rate',
            '84%',
            Icons.check_circle_outline,
            AppColors.success,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _reportStatCard(
            context,
            'Avg Score',
            '72.5',
            Icons.bar_chart_outlined,
            AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _reportStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return AppCard(
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: color),
          ),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _mockChart(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _bar(context, 0.2, '0-20'),
          _bar(context, 0.4, '21-40'),
          _bar(context, 0.8, '41-60'),
          _bar(context, 1.0, '61-80', isPrimary: true),
          _bar(context, 0.6, '81-100'),
        ],
      ),
    );
  }

  Widget _bar(
    BuildContext context,
    double height,
    String label, {
    bool isPrimary = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 32,
          height: 150 * height,
          decoration: BoxDecoration(
            color:
                isPrimary
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _buildQuestionDifficultyList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        double difficulty = [0.1, 0.4, 0.7, 0.3, 0.9][index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Question #${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 7,
                child: LinearProgressIndicator(
                  value: difficulty,
                  backgroundColor: Colors.grey.withOpacity(0.1),
                  color: difficulty > 0.7 ? AppColors.error : AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(difficulty * 100).toInt()}% Fail Rate',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    );
  }
}

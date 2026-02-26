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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-time Monitor'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSummaryBar(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 15,
              itemBuilder: (context, index) {
                bool isRisk = index % 4 == 0;
                return _buildStudentSessionCard(context, index, isRisk);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColor.withOpacity(0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _summaryItem(context, 'In Progress', '124', AppColors.primary),
          _summaryItem(context, 'Submitted', '12', AppColors.success),
          _summaryItem(context, 'High Risk', '4', AppColors.error),
        ],
      ),
    );
  }

  Widget _summaryItem(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildStudentSessionCard(
    BuildContext context,
    int index,
    bool isRisk,
  ) {
    return AppCard(
      onTap: () => _showSessionDetails(context),
      color: isRisk ? AppColors.error.withOpacity(0.05) : null,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student ${1001 + index}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Last active: 2 min ago',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (isRisk)
            const AppBadge(label: 'Risk Detected', color: AppColors.error)
          else
            const AppBadge(label: 'Healthy', color: AppColors.success),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, size: 20),
        ],
      ),
    );
  }

  void _showSessionDetails(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Session Timeline',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _timelineItem(
              context,
              '10:00 AM',
              'Exam Started',
              Icons.play_arrow,
            ),
            _timelineItem(
              context,
              '10:15 AM',
              'Focus Lost (Left Application)',
              Icons.warning,
              color: AppColors.warning,
            ),
            _timelineItem(
              context,
              '10:17 AM',
              'Focus Regained',
              Icons.check_circle_outline,
            ),
            _timelineItem(
              context,
              '10:25 AM',
              'Screen Recording Detected',
              Icons.error_outline,
              color: AppColors.error,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Invalidate Exam'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _timelineItem(
    BuildContext context,
    String time,
    String action,
    IconData icon, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(time, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(width: 16),
          Icon(icon, size: 16, color: color ?? AppColors.success),
          const SizedBox(width: 8),
          Text(action, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

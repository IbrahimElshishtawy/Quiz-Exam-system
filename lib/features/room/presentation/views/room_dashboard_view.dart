import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/app_card.dart';
import '../../../../core/components/app_badge.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';

class RoomDashboardView extends StatelessWidget {
  const RoomDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CS-201: Computer Science'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsGrid(context),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active & Upcoming Exams', style: Theme.of(context).textTheme.titleLarge),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.EXAM_BUILDER),
                  child: const Text('+ Create New'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildExamCard(context, 'Midterm Exam', 'In Progress', AppColors.success, '24/40 Students'),
            _buildExamCard(context, 'Final Quiz', 'Scheduled', AppColors.warning, 'May 15, 10:00 AM'),
            const SizedBox(height: 32),
            Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _actionChip(context, Icons.upload_file, 'Upload Question Bank'),
                _actionChip(context, Icons.person_add_outlined, 'Invite Students'),
                _actionChip(context, Icons.analytics_outlined, 'View All Reports'),
                _actionChip(context, Icons.password_outlined, 'Rotate Password'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _statCard(context, 'Students', '156', Icons.people_outline),
        _statCard(context, 'Exams', '12', Icons.assignment_outlined),
        _statCard(context, 'Pass Rate', '88%', Icons.trending_up),
        _statCard(context, 'Avg Score', '74.5', Icons.assessment_outlined),
      ],
    );
  }

  Widget _statCard(BuildContext context, String label, String value, IconData icon) {
    return AppCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.headlineMedium),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildExamCard(BuildContext context, String title, String status, Color statusColor, String info) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        onTap: () => Get.toNamed(Routes.EXAM_MONITOR),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(info, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            AppBadge(label: status, color: statusColor),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _actionChip(BuildContext context, IconData icon, String label) {
    return FilterChip(
      onSelected: (_) {},
      avatar: Icon(icon, size: 16),
      label: Text(label),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}

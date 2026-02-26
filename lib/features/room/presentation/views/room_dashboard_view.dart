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
          IconButton(
            onPressed: () {
              Get.snackbar(
                'Settings',
                'Room settings (demo)',
                backgroundColor: Colors.black87,
                colorText: Colors.white,
              );
            },
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
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
                  _RoomHeaderCard(),
                  const SizedBox(height: 14),

                  _buildStatsGrid(context),
                  const SizedBox(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Active & Upcoming Exams',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => Get.toNamed(Routes.EXAM_BUILDER),
                        icon: const Icon(Icons.add),
                        label: const Text('Create New'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _ExamCard(
                    title: 'Midterm Exam',
                    status: 'In Progress',
                    statusColor: AppColors.success,
                    info: '24/40 Students',
                    icon: Icons.play_circle_outline,
                    onTap: () => Get.toNamed(Routes.EXAM_MONITOR),
                  ),
                  const SizedBox(height: 12),
                  _ExamCard(
                    title: 'Final Quiz',
                    status: 'Scheduled',
                    statusColor: AppColors.warning,
                    info: 'May 15, 10:00 AM',
                    icon: Icons.event_available_outlined,
                    onTap: () => Get.toNamed(Routes.EXAM_MONITOR),
                  ),

                  const SizedBox(height: 22),

                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _ActionsGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth >= 720;
        final crossAxisCount = isWide ? 4 : 2;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: isWide ? 1.7 : 1.5,
          children: const [
            _StatCard(
              label: 'Students',
              value: '156',
              icon: Icons.people_outline,
            ),
            _StatCard(
              label: 'Exams',
              value: '12',
              icon: Icons.assignment_outlined,
            ),
            _StatCard(
              label: 'Pass Rate',
              value: '88%',
              icon: Icons.trending_up,
            ),
            _StatCard(
              label: 'Avg Score',
              value: '74.5',
              icon: Icons.assessment_outlined,
            ),
          ],
        );
      },
    );
  }
}

/// ---------------- UI Pieces ----------------

class _RoomHeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.class_, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CS-201: Computer Science',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Instructor: Dr. Ahmed • Room code: CS201',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            AppBadge(label: 'Live', color: AppColors.success),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

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
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
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

class _ExamCard extends StatelessWidget {
  const _ExamCard({
    required this.title,
    required this.status,
    required this.statusColor,
    required this.info,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String status;
  final Color statusColor;
  final String info;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: statusColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
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
}

class _ActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionTileData(
        icon: Icons.upload_file,
        label: 'Upload Question Bank',
        onTap: () => Get.snackbar('Action', 'Upload (demo)'),
      ),
      _ActionTileData(
        icon: Icons.person_add_outlined,
        label: 'Invite Students',
        onTap: () => Get.snackbar('Action', 'Invite (demo)'),
      ),
      _ActionTileData(
        icon: Icons.analytics_outlined,
        label: 'View All Reports',
        onTap: () => Get.toNamed(Routes.EXAM_ANALYTICS),
      ),
      _ActionTileData(
        icon: Icons.password_outlined,
        label: 'Rotate Password',
        onTap: () => Get.snackbar('Action', 'Rotate password (demo)'),
      ),
    ];

    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth >= 720;
        final crossAxisCount = isWide ? 4 : 2;

        return GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: isWide ? 1.25 : 1.35,
          children: actions.map((a) => _ActionTile(data: a)).toList(),
        );
      },
    );
  }
}

class _ActionTileData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _ActionTileData({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.data});

  final _ActionTileData data;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: data.onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(data.icon, color: AppColors.primary),
            ),
            const Spacer(),
            Text(
              data.label,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap to open',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

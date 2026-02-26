import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../routes/app_routes.dart';
import '../../../../core/config/app_config.dart';

class DeveloperDashboardView extends StatelessWidget {
  const DeveloperDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () async {
              await box.remove('user_role');
              Get.offAllNamed(Routes.LOGIN);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Role: ${box.read('user_role') ?? 'unknown'}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Demo Mode: ${AppConfig.isDemoMode}'),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Get.snackbar('Storage', box.getKeys().toString());
              },
              child: const Text('Show Storage Keys'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                await box.erase();
                Get.snackbar('Done', 'Storage cleared');
                Get.offAllNamed(Routes.LOGIN);
              },
              child: const Text('Clear Storage + Back to Login'),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // اختياري: تنقل سريع لشاشات موجودة عندك
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.EXAM_DETAILS),
              child: const Text('Go to Exam Details'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.INSTRUCTOR_DASHBOARD),
              child: const Text('Go to Instructor Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/exam_monitoring_controller.dart';
import 'tabs/monitor_dashboard_tab.dart';
import 'tabs/monitor_grid_tab.dart';
import 'tabs/monitor_history_tab.dart';
import 'tabs/monitor_settings_tab.dart';

class ExamMonitorLayout extends GetView<ExamMonitoringController> {
  const ExamMonitorLayout({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?w=100&auto=format&fit=crop&q=80'),
          ),
        ),
        title: Text(
          'إدارة الاختبارات',
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded, color: textDark),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final int activeIndex = controller.currentTabIndex.value;
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Container(
              key: ValueKey<int>(activeIndex),
              child: _getTabWidget(activeIndex),
            ),
          );
        }),
      ),
      bottomNavigationBar: Obx(() {
        final int activeIndex = controller.currentTabIndex.value;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
            border: const Border(
              top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(3, Icons.settings_outlined, 'الإعدادات', activeIndex == 3),
                  _buildNavItem(2, Icons.history_rounded, 'السجل', activeIndex == 2),
                  _buildNavItem(1, Icons.visibility_outlined, 'مراقبة', activeIndex == 1),
                  _buildNavItem(0, Icons.grid_view_rounded, 'الرئيسية', activeIndex == 0),
                ].reversed.toList(), // Ensure standard RTL ordering (Right = Home, Left = Settings)
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _getTabWidget(int index) {
    switch (index) {
      case 0:
        return const MonitorDashboardTab();
      case 1:
        return const MonitorGridTab();
      case 2:
        return const MonitorHistoryTab();
      case 3:
        return const MonitorSettingsTab();
      default:
        return const MonitorDashboardTab();
    }
  }

  Widget _buildNavItem(int index, IconData icon, String label, bool isActive) {
    const primaryColor = Color(0xFF005BBF);
    const inactiveColor = Color(0xFF94A3B8);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.currentTabIndex.value = index,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFEFF6FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? primaryColor : inactiveColor,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? primaryColor : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

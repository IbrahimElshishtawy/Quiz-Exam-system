import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/instructor_dashboard_controller.dart';
import 'instructor_home_tab.dart';
import 'instructor_exams_tab.dart';
import 'instructor_ai_assistant_tab.dart';
import 'instructor_reports_tab.dart';
import 'instructor_settings_tab.dart';

class InstructorDashboardLayout extends GetView<InstructorDashboardController> {
  const InstructorDashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final int activeIndex = controller.currentTabIndex.value;

        // Optimized AnimatedSwitcher for lag-free horizontal fade-slide tab shifts
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.04, 0.0), // subtle RTL slide
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Container(
            key: ValueKey<int>(activeIndex),
            child: _getTabWidget(activeIndex),
          ),
        );
      }),
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
                  _buildNavItem(0, Icons.home_rounded, 'الرئيسية', activeIndex == 0),
                  _buildNavItem(1, Icons.calendar_today_rounded, 'الامتحانات', activeIndex == 1),
                  _buildNavItem(2, Icons.smart_toy_rounded, 'المساعد', activeIndex == 2),
                  _buildNavItem(3, Icons.analytics_rounded, 'التقارير', activeIndex == 3),
                  _buildNavItem(4, Icons.settings_rounded, 'الإعدادات', activeIndex == 4),
                ],
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
        return const InstructorHomeTab();
      case 1:
        return const InstructorExamsTab();
      case 2:
        return const InstructorAiAssistantTab();
      case 3:
        return const InstructorReportsTab();
      case 4:
        return const InstructorSettingsTab();
      default:
        return const InstructorHomeTab();
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
          duration: const Duration(milliseconds: 250),
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

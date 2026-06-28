import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/student_dashboard_controller.dart';
import 'student_home_tab.dart';
import 'student_schedule_tab.dart';
import 'student_ai_assistant_tab.dart';
import 'student_notifications_tab.dart';
import 'student_settings_tab.dart';

class StudentDashboardLayout extends GetView<StudentDashboardController> {
  const StudentDashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Scaffold(
      body: Obx(() {
        final int activeIndex = controller.currentTabIndex.value;
        
        // AnimatedSwitcher for smooth fade-slide tab shifts
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.04, 0.0), // Subtle horizontal slide
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

        // Custom Navigation Bar to ensure premium look and feel
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
                  _buildNavItem(1, Icons.calendar_month_rounded, 'الجدول', activeIndex == 1),
                  _buildNavItem(2, Icons.smart_toy_rounded, 'المساعد', activeIndex == 2),
                  _buildNavItem(3, Icons.notifications_rounded, 'تنبيهات', activeIndex == 3, showBadge: true),
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
        return const StudentHomeTab();
      case 1:
        return const StudentScheduleTab();
      case 2:
        return const StudentAiAssistantTab();
      case 3:
        return const StudentNotificationsTab();
      case 4:
        return const StudentSettingsTab();
      default:
        return const StudentHomeTab();
    }
  }

  Widget _buildNavItem(int index, IconData icon, String label, bool isActive, {bool showBadge = false}) {
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
            color: isActive ? const Color(0xFFEFF6FF) : Colors.transparent, // soft active background
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    icon,
                    color: isActive ? primaryColor : inactiveColor,
                    size: 24,
                  ),
                  
                  // Red notification dot badge
                  if (showBadge)
                    Obx(() {
                      final hasUnread = controller.notifications.any((n) => !n.isRead);
                      if (!hasUnread) return const SizedBox.shrink();
                      
                      return Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                ],
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

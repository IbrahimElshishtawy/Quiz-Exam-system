import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/exam_builder_controller.dart';
import 'exam_builder_home_tab.dart';
import 'exam_builder_create_tab.dart';
import 'exam_builder_history_tab.dart';
import 'exam_builder_settings_tab.dart';

class ExamBuilderLayout extends GetView<ExamBuilderController> {
  const ExamBuilderLayout({super.key});

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
                  _buildNavItem(0, Icons.grid_view_rounded, 'الرئيسية', activeIndex == 0),
                  _buildNavItem(1, Icons.add_circle_outline_rounded, 'إنشاء', activeIndex == 1),
                  _buildNavItem(2, Icons.history_toggle_off_rounded, 'السجل', activeIndex == 2),
                  _buildNavItem(3, Icons.settings_rounded, 'الإعدادات', activeIndex == 3),
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
        return const ExamBuilderHomeTab();
      case 1:
        return const ExamBuilderCreateTab();
      case 2:
        return const ExamBuilderHistoryTab();
      case 3:
        return const ExamBuilderSettingsTab();
      default:
        return const ExamBuilderHomeTab();
    }
  }

  Widget _buildNavItem(int index, IconData icon, String label, bool isActive) {
    const primaryColor = Color(0xFF005BBF);
    const inactiveColor = Color(0xFF94A3B8);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          controller.currentTabIndex.value = index;
          if (index == 1) {
            controller.resetWizard(); // Reset wizard form on clicking Create
          }
        },
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

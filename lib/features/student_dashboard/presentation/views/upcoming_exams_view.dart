import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/student_dashboard_controller.dart';
import '../widgets/upcoming_exam_card_widget.dart';
import '../../domain/entities/exam_schedule_entity.dart';

class UpcomingExamsView extends GetView<StudentDashboardController> {
  const UpcomingExamsView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.calendar_today_rounded, color: primaryColor),
          onPressed: () {
            // Navigate to calendar tab
            controller.currentTabIndex.value = 1;
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'الامتحانات القادمة',
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_rounded, color: primaryColor),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Category Filter Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Obx(() {
                final String activeFilter = controller.upcomingExamsFilter.value;

                return Row(
                  children: [
                    _buildFilterPill('mock', 'تجريبي', activeFilter == 'mock'),
                    const SizedBox(width: 12),
                    _buildFilterPill('academic', 'أكاديمي', activeFilter == 'academic'),
                    const SizedBox(width: 12),
                    _buildFilterPill('all', 'الكل', activeFilter == 'all'),
                  ],
                );
              }),
            ),

            // Vertical list of grouped upcoming exams
            Expanded(
              child: Obx(() {
                final List<ExamScheduleEntity> list = controller.getFilteredUpcomingExams();

                if (list.isEmpty) {
                  return Center(
                    child: Text(
                      'لا توجد امتحانات قادمة مطابقة.',
                      style: GoogleFonts.notoKufiArabic(color: const Color(0xFF64748B)),
                    ),
                  );
                }

                // Group lists by: اليوم (11), غداً (12), الأسبوع القادم (> 12)
                final List<ExamScheduleEntity> todayExams = list.where((e) => e.dateTime.day == 11).toList();
                final List<ExamScheduleEntity> tomorrowExams = list.where((e) => e.dateTime.day == 12).toList();
                final List<ExamScheduleEntity> nextWeekExams = list.where((e) => e.dateTime.day > 12 || e.dateTime.day < 11).toList(); // other days

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  children: [
                    // Group 1: اليوم (Today)
                    if (todayExams.isNotEmpty) ...[
                      _buildGroupHeader('اليوم', Colors.redAccent),
                      ...todayExams.map((e) => UpcomingExamCardWidget(exam: e)),
                    ],

                    // Group 2: غداً (Tomorrow)
                    if (tomorrowExams.isNotEmpty) ...[
                      _buildGroupHeader('غداً', Colors.blueAccent),
                      ...tomorrowExams.map((e) => UpcomingExamCardWidget(exam: e)),
                    ],

                    // Group 3: الأسبوع القادم (Next Week)
                    if (nextWeekExams.isNotEmpty) ...[
                      _buildGroupHeader('الأسبوع القادم', const Color(0xFF64748B)),
                      ...nextWeekExams.map((e) => UpcomingExamCardWidget(exam: e)),
                    ],
                  ],
                );
              }),
            ),
          ],
        ),
      ),
      // Bottom left Floating action button "Mascot Helper"
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, bottom: 8.0),
          child: FloatingActionButton(
            onPressed: () {
              controller.currentTabIndex.value = 2; // AI Chat
              Get.back();
            },
            backgroundColor: const Color(0xFF10B981), // Green helper
            shape: const CircleBorder(),
            child: const Icon(Icons.psychology_rounded, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupHeader(String title, Color dotColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPill(String filterValue, String text, bool isActive) {
    const primaryColor = Color(0xFF005BBF);

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.upcomingExamsFilter.value = filterValue,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 38,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.notoKufiArabic(
              color: isActive ? Colors.white : const Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

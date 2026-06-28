import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/student_dashboard_controller.dart';
import '../widgets/custom_calendar_widget.dart';
import '../../domain/entities/exam_schedule_entity.dart';

class StudentScheduleTab extends GetView<StudentDashboardController> {
  const StudentScheduleTab({super.key});

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
          icon: const Icon(Icons.search, color: Color(0xFF64748B)),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          'EduAssess AI',
          style: GoogleFonts.ibmPlexSans(
            color: primaryColor,
            fontSize: 22,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. "جدولك الدراسي" Blue Banner Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE), // Light blue-purple
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'جدولك الدراسي',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'تابع مواعيد اختباراتك القادمة والتحضيرات الذكية.',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 12,
                        color: const Color(0xFF1E3A8A),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. Google Calendar Sync Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Right: Sync Status Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مزامنة التقويم',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.notoKufiArabic(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Obx(() => Text(
                                'آخر مزامنة: ${controller.lastSyncTime.value}',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.notoKufiArabic(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B),
                                ),
                              )),
                        ],
                      ),
                    ),

                    // Left: Sync button
                    Obx(() {
                      final bool syncing = controller.isSyncing.value;

                      return ElevatedButton.icon(
                        onPressed: syncing ? null : () => controller.syncGoogleCalendar(),
                        icon: syncing
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Icon(Icons.sync_rounded, color: Colors.white, size: 16),
                        label: Text(
                          'مزامنة مع Google',
                          style: GoogleFonts.notoKufiArabic(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 3. Calendar Grid Widget
              const CustomCalendarWidget(),
              const SizedBox(height: 24),

              // 4. "اختبارات اليوم" Task List Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Task Count Badge
                  Obx(() {
                    final date = controller.selectedDate.value;
                    final list = controller.getFilteredSchedulesForDate(date);
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${list.length} مهام',
                        style: GoogleFonts.notoKufiArabic(
                          color: primaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                  
                  // Section title
                  Obx(() {
                    final date = controller.selectedDate.value;
                    return Text(
                      'اختبارات اليوم (${date.day} سبتمبر)',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 12),

              // Vertically listed tasks for selected date
              Obx(() {
                final date = controller.selectedDate.value;
                final List<ExamScheduleEntity> dailyExams = controller.getFilteredSchedulesForDate(date);

                if (dailyExams.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: Text(
                        'لا توجد امتحانات في هذا اليوم.',
                        style: GoogleFonts.notoKufiArabic(
                          color: const Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  children: dailyExams.map((exam) => _buildScheduleTaskCard(exam)).toList(),
                );
              }),
            ],
          ),
        ),
      ),
      // Bottom left Floating action button "+"
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, bottom: 8.0),
          child: FloatingActionButton(
            onPressed: () {
              Get.snackbar('إضافة موعد', 'هذه الميزة تتيح لك إضافة موعد مراجعة يدوي.');
            },
            backgroundColor: primaryColor,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleTaskCard(ExamScheduleEntity exam) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    final bool isConfirmed = exam.status == 'confirmed';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // Left chevron arrow
          const Icon(Icons.chevron_left_rounded, color: Color(0xFF94A3B8), size: 22),
          const SizedBox(width: 12),

          // Details info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and status badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Status Badge (Confirmed or Preparatory)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isConfirmed ? const Color(0xFFD1FAE5) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isConfirmed ? 'مؤكد' : 'تحضيري',
                        style: GoogleFonts.notoKufiArabic(
                          color: isConfirmed ? const Color(0xFF065F46) : const Color(0xFF64748B),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Title Text
                    Expanded(
                      child: Text(
                        exam.title,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.notoKufiArabic(
                          color: textDark,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Location details & Time specifications
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Time
                    Text(
                      exam.timeString,
                      style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xFF64748B),
                        fontSize: 10.5,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.access_time_rounded, color: Color(0xFF94A3B8), size: 14),
                    const SizedBox(width: 14),

                    // Location
                    Text(
                      exam.location,
                      style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xFF64748B),
                        fontSize: 10.5,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      exam.location == 'عبر الإنترنت' ? Icons.laptop_chromebook_rounded : Icons.location_on_outlined,
                      color: const Color(0xFF94A3B8),
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Right Icon Box
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: exam.iconCode == 'flask' ? const Color(0xFFD1FAE5) : const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              exam.iconCode == 'flask' ? Icons.science_outlined : Icons.calculate_outlined,
              color: exam.iconCode == 'flask' ? const Color(0xFF047857) : primaryColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

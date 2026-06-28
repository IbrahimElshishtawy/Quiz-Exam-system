import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/instructor_dashboard_controller.dart';
import '../widgets/instructor_exam_card.dart';
import '../widgets/proctoring_alert_card.dart';

class InstructorExamsTab extends GetView<InstructorDashboardController> {
  const InstructorExamsTab({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: primaryColor),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Live blinking green dot
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'الامتحانات النشطة الآن',
              style: GoogleFonts.notoKufiArabic(
                color: textDark,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF64748B)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search field
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'ابحث عن اختبار، مادة، أو فصل...',
                          hintStyle: GoogleFonts.notoKufiArabic(
                            color: const Color(0xFF94A3B8),
                            fontSize: 12,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Exams List
              Obx(() {
                final list = controller.exams.where((e) => !e.id.contains('prog')).toList();
                return Column(
                  children: list.map((exam) => InstructorExamCard(exam: exam)).toList(),
                );
              }),
              const SizedBox(height: 16),

              // Blue General Overview Card: "نظرة عامة اليوم"
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [primaryColor, Color(0xFF1E3A8A)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'نظرة عامة اليوم',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.notoKufiArabic(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'إجمالي الحضور ومستوى الفحص في الامتحانات الجارية.',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.notoKufiArabic(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 10.5,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Stats Row
                    Row(
                      children: [
                        // Stat 1: 98%
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '98%',
                                style: GoogleFonts.ibmPlexSans(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'معدل الحضور',
                                style: GoogleFonts.notoKufiArabic(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Splitter
                        Container(width: 1, height: 35, color: Colors.white.withOpacity(0.2)),
                        // Stat 2: 605
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '605',
                                style: GoogleFonts.ibmPlexSans(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'طالب نشط اليوم',
                                style: GoogleFonts.notoKufiArabic(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // "تنبيهات الذكاء الاصطناعي الفورية" Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'تنبيهات الذكاء الاصطناعي الفورية',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.notifications_active_outlined, color: primaryColor, size: 20),
                ],
              ),
              const SizedBox(height: 12),

              // Proctoring Alerts List
              Obx(() {
                final list = controller.alerts;
                return Column(
                  children: list.map((alert) => ProctoringAlertCard(alert: alert)).toList(),
                );
              }),
            ],
          ),
        ),
      ),
      // Floating left add button "+"
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, bottom: 8.0),
          child: FloatingActionButton(
            onPressed: () => Get.toNamed(Routes.EXAM_BUILDER),
            backgroundColor: primaryColor,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}

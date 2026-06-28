import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/student_dashboard_controller.dart';
import '../widgets/join_exam_banner_widget.dart';
import '../widgets/exam_today_card.dart';
import '../widgets/achievement_grid_widget.dart';
import '../widgets/recent_activity_list_widget.dart';

class StudentHomeTab extends GetView<StudentDashboardController> {
  const StudentHomeTab({super.key});

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
              // Welcome Greeting
              Text(
                'أهلاً بك، أحمد 👋',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'لديك اختبارين مجدولين لهذا اليوم. استعد جيداً!',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 24),

              // Search Bar
              Container(
                height: 52,
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
                          hintText: 'ابحث عن اختبار، مادة، أو نتيجة...',
                          hintStyle: GoogleFonts.notoKufiArabic(
                            color: const Color(0xFF94A3B8),
                            fontSize: 12.5,
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
              const SizedBox(height: 24),

              // Join Session Banner Card
              const JoinExamBannerWidget(),
              const SizedBox(height: 28),

              // "اختبارات اليوم" Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.UPCOMING_EXAMS),
                    child: Text(
                      'عرض الكل',
                      style: GoogleFonts.notoKufiArabic(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'اختبارات اليوم',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Horizontal Scrolling list of today's exams
              Obx(() {
                final List<ExamTodayCard> cards = controller.schedules
                    .where((e) => e.dateTime.day == 11) // Sep 11
                    .map((exam) => ExamTodayCard(exam: exam))
                    .toList();

                if (cards.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        'لا توجد اختبارات مجدولة اليوم.',
                        style: GoogleFonts.notoKufiArabic(color: const Color(0xFF64748B)),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 190,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    reverse: true, // Right-to-Left scroll feel
                    children: cards,
                  ),
                );
              }),
              const SizedBox(height: 28),

              // "ملخص الإنجاز" Section Header
              Text(
                'ملخص الإنجاز',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 12),

              // Achievements Grid
              Obx(() {
                final achs = controller.achievements.value;
                if (achs == null) return const SizedBox.shrink();
                return AchievementGridWidget(achievements: achs);
              }),
              const SizedBox(height: 28),

              // "النشاط الأخير" Section Header
              Text(
                'النشاط الأخير',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 12),

              // Recent Activities List
              const RecentActivityListWidget(),
              const SizedBox(height: 20),

              // AI Review Promo Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      alignSelf: Alignment.start,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'متاح حصرياً',
                        style: GoogleFonts.notoKufiArabic(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'مراجعة الذكاء الاصطناعي',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.notoKufiArabic(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'احصل على خطة مراجعة مخصصة تعتمد على أدائك في الاختبارات السابقة.',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xFF94A3B8),
                        fontSize: 11,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        controller.currentTabIndex.value = 2; // AI Tab
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'جربه الآن',
                        style: GoogleFonts.notoKufiArabic(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Floating chat mascot button
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.currentTabIndex.value = 2, // Go to AI chat
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white),
      ),
    );
  }
}

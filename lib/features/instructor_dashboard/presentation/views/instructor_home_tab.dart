import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/instructor_dashboard_controller.dart';
import '../widgets/instructor_stat_card_widget.dart';
import '../widgets/ongoing_exam_progress_card.dart';

class InstructorHomeTab extends GetView<InstructorDashboardController> {
  const InstructorHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: primaryColor,
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
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
            icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF64748B)),
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
              // Welcome greeting
              Text(
                'أهلاً، أ/ أحمد 👋',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'بوابة المعلم الذكية • إدارة الاختبارات والتقارير',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 24),

              // Stats Grid (4 cards, 2x2)
              Obx(() {
                final st = controller.stats.value;
                if (st == null) return const SizedBox.shrink();

                return GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.35,
                  children: [
                    InstructorStatCardWidget(
                      title: 'اختبارات نشطة',
                      value: '${st.activeExamsCount}',
                      icon: Icons.timer_outlined,
                      iconBgColor: const Color(0xFFEFF6FF),
                      iconColor: primaryColor,
                      badgeText: '2 اليوم',
                      badgeBgColor: const Color(0xFFECFDF5),
                      badgeTextColor: const Color(0xFF10B981),
                    ),
                    InstructorStatCardWidget(
                      title: 'إجمالي الطلاب',
                      value: '${st.totalStudentsCount}',
                      icon: Icons.groups_outlined,
                      iconBgColor: const Color(0xFFF1F5F9),
                      iconColor: const Color(0xFF64748B),
                    ),
                    InstructorStatCardWidget(
                      title: 'متوسط الدرجات',
                      value: '${st.averageGradePercentage.toInt()}%',
                      icon: Icons.star_outline_rounded,
                      iconBgColor: const Color(0xFFFFF7ED),
                      iconColor: const Color(0xFFD97706),
                      badgeText: '↑ 4%',
                      badgeBgColor: const Color(0xFFEFF6FF),
                      badgeTextColor: primaryColor,
                    ),
                    InstructorStatCardWidget(
                      title: 'تقارير معلقة',
                      value: '${st.pendingReportsCount}',
                      icon: Icons.assignment_outlined,
                      iconBgColor: const Color(0xFFFEE2E2),
                      iconColor: const Color(0xFFEF4444),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 28),

              // "الاختبارات الجارية حالياً" Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => controller.currentTabIndex.value = 1, // Go to Exams
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
                    'الاختبارات الجارية حالياً',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Progress bars list
              Obx(() {
                final list = controller.exams.where((e) => e.id.contains('prog')).toList();
                return Column(
                  children: list.map((exam) => OngoingExamProgressCard(exam: exam)).toList(),
                );
              }),
              const SizedBox(height: 10),

              // Intelligent Proctoring status badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFDBEAFE)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'نظام المراقبة الذكي لا يرصد مخالفات حالياً',
                      style: GoogleFonts.notoKufiArabic(
                        color: primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.shield_outlined, color: primaryColor, size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Create Exam banner button (AI driven)
              InkWell(
                onTap: () => Get.toNamed(Routes.EXAM_BUILDER),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [primaryColor, Color(0xFF1D4ED8)],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 18),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'إنشاء اختبار جديد',
                                style: GoogleFonts.notoKufiArabic(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'باستخدام الذكاء الاصطناعي',
                                style: GoogleFonts.notoKufiArabic(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 14),
                          const Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 28),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Row of reports & attendance buttons
              Row(
                children: [
                  // Track Attendance Button
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.snackbar('رصد الحضور', 'سيتم فتح كاميرا الفصل الذكي لرصد الحضور.');
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.how_to_reg_rounded, color: Color(0xFF64748B), size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'رصد الحضور',
                              style: GoogleFonts.notoKufiArabic(
                                color: const Color(0xFF64748B),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Reports Button
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.currentTabIndex.value = 3, // Go to Reports
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.analytics_outlined, color: Color(0xFF64748B), size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'التقارير',
                              style: GoogleFonts.notoKufiArabic(
                                color: const Color(0xFF64748B),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // "آخر النشاطات" Section Header
              Text(
                'آخر النشاطات',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 12),

              // Activities Card list
              _buildActivityItem('أحمد محمود سلم اختبار اللغة العربية', 'منذ 5 دقائق', 'النتيجة: 92/100', Colors.emerald),
              _buildActivityItem('تم إنشاء تقرير الأداء الفصلي للفصل أ/1', 'منذ 20 دقيقة', 'جاهز للتحميل والتصدير', primaryColor),
              _buildActivityWarningItem('سارة علي لم تكمل الاختبار (انقطاع الاتصال)', 'منذ ساعة', 'مراسلة'),
              const SizedBox(height: 24),

              // AI Recommendation Promo Banner (Dark green card)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF022C22), // Deep dark green
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'توصية الذكاء الاصطناعي',
                          style: GoogleFonts.notoKufiArabic(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.auto_awesome, color: Color(0xFF34D399), size: 18),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'يواجه 40% من الطلاب صعوبة في "قواعد الإعراب". نقترح إجراء مراجعة سريعة قبل الاختبار القادم.',
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
                        Get.snackbar('إنشاء ورقة مراجعة', 'تم إرسال ورقة مراجعة النحو لجميع الطلاب المشتركين.');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF059669), // Green
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'إنشاء ورقة مراجعة',
                        style: GoogleFonts.notoKufiArabic(fontSize: 11.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget _buildActivityItem(String text, String time, String sub, Color badgeColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Sub-info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              sub,
              style: GoogleFonts.notoKufiArabic(
                color: badgeColor,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Core Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 9,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityWarningItem(String text, String time, String actionText) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F2), // Rose/pink warning bg
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Message Action
          OutlinedButton(
            onPressed: () => controller.sendReminder('سارة علي'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.redAccent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            child: Text(
              actionText,
              style: GoogleFonts.notoKufiArabic(
                color: Colors.redAccent,
                fontSize: 9.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Core Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF9F1239),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 9,
                    color: const Color(0xFFF43F5E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

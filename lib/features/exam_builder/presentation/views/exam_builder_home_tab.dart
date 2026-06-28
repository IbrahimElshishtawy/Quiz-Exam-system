import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/exam_builder_controller.dart';
import '../widgets/exam_draft_card.dart';
import '../widgets/builder_activity_item.dart';

class ExamBuilderHomeTab extends GetView<ExamBuilderController> {
  const ExamBuilderHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    final List<String> filterOptions = ['الكل', 'نشط', 'مسودة', 'مؤرشف'];

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
          'إدارة الاختبارات',
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF64748B)),
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
              // Welcome Text
              Text(
                'مرحباً، أ. أحمد علي 👋',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'إليك نظرة سريعة على اختباراتك الحالية وجدول المهام.',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 20),

              // Stats Row (1,240 Total Students & 85% Corrected)
              Row(
                children: [
                  // Stat 1: 85% Corrected
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '85%',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: textDark,
                                ),
                              ),
                              Text(
                                'تم تصحيحه',
                                style: GoogleFonts.notoKufiArabic(
                                  fontSize: 10,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF10B981), size: 24),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Stat 2: Total Students
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '1,240',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: textDark,
                                ),
                              ),
                              Text(
                                'إجمالي الطلاب',
                                style: GoogleFonts.notoKufiArabic(
                                  fontSize: 10,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.groups_outlined, color: primaryColor, size: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search box
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.right,
                        style: GoogleFonts.notoKufiArabic(fontSize: 12.5),
                        onChanged: (val) => controller.searchQuery.value = val,
                        decoration: InputDecoration(
                          hintText: 'ابحث عن اختبار معين...',
                          hintStyle: GoogleFonts.notoKufiArabic(
                            color: const Color(0xFF94A3B8),
                            fontSize: 11.5,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Filter row: الكل, نشط, مسودة, مؤرشف
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true, // RTL flow
                child: Obx(() {
                  final active = controller.activeFilter.value;

                  return Row(
                    children: filterOptions.map((opt) {
                      final isSelected = active == opt;

                      return GestureDetector(
                        onTap: () => controller.activeFilter.value = opt,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? primaryColor : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Text(
                            opt,
                            style: GoogleFonts.notoKufiArabic(
                              color: isSelected ? Colors.white : const Color(0xFF64748B),
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Exams list view
              Obx(() {
                final list = controller.filteredExams;
                if (list.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    alignment: Alignment.center,
                    child: Text(
                      'لا يوجد اختبارات مطابقة للتصفية',
                      style: GoogleFonts.notoKufiArabic(color: const Color(0xFF94A3B8), fontSize: 12),
                    ),
                  );
                }
                return Column(
                  children: list.map((exam) => ExamDraftCard(exam: exam)).toList(),
                );
              }),
              const SizedBox(height: 16),

              // AI Brain Card Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A), // Very dark slate/blue
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Glowing brain icon/design simulation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'نشئ اختبارك القادم بالذكاء الاصطناعي',
                          style: GoogleFonts.notoKufiArabic(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.auto_awesome, color: Color(0xFF60A5FA), size: 20),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ارفع المنهج الدراسي ودع النظام يولد لك بنكاً من الأسئلة المتنوعة والموزعة حسب مستويات الصعوبة في ثوانٍ.',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.notoKufiArabic(
                        color: const Color(0xFF94A3B8),
                        fontSize: 10.5,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Glowing brain background graphic placeholder
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF334155)),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.psychology_outlined,
                        color: Color(0xFF60A5FA),
                        size: 64,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Text button: "ابدأ الآن"
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          controller.currentTabIndex.value = 1; // Go to Create tab
                          controller.resetWizard();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_back, color: Color(0xFF60A5FA), size: 16),
                            const SizedBox(width: 6),
                            Text(
                              'ابدأ الآن',
                              style: GoogleFonts.notoKufiArabic(
                                color: const Color(0xFF60A5FA),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // "النشاط الأخير" Header
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'النشاط الأخير',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.history_toggle_off_rounded, color: primaryColor, size: 18),
                ],
              ),
              const SizedBox(height: 12),

              // Activity logs
              Obx(() {
                final list = controller.activities;
                return Column(
                  children: list.map((act) => BuilderActivityItem(activity: act)).toList(),
                );
              }),
              const SizedBox(height: 8),

              // "عرض كل النشاطات" button
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.snackbar('السجل الكامل', 'سيتم تحويلك إلى صفحة السجل التفصيلي.');
                  },
                  child: Text(
                    'عرض كل النشاطات',
                    style: GoogleFonts.notoKufiArabic(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Floating left Action button "+"
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, bottom: 8.0),
          child: FloatingActionButton(
            onPressed: () {
              controller.currentTabIndex.value = 1; // Go to Create tab
              controller.resetWizard();
            },
            backgroundColor: primaryColor,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}

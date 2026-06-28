import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/exam_builder_controller.dart';

class ExamBuilderReviewStep extends GetView<ExamBuilderController> {
  const ExamBuilderReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    final title = controller.titleCtrl.text.isEmpty
        ? 'اختبار منتصف الفصل: علم الأحياء'
        : controller.titleCtrl.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top "مراجعة نهائية" Badge Row
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'مراجعة نهائية',
              style: GoogleFonts.notoKufiArabic(
                color: const Color(0xFF10B981),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 16),
          ],
        ),
        const SizedBox(height: 10),

        // Exam Title
        Text(
          title,
          textAlign: TextAlign.right,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
        ),
        const SizedBox(height: 4),

        // Subtitle instructions
        Text(
          'يرجى مراجعة تفاصيل الاختبار بعناية قبل النشر للطلاب.',
          textAlign: TextAlign.right,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 11,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),

        // Row of "تعديل" and "عرض كطالب" buttons
        Row(
          children: [
            // Preview as student button
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Get.snackbar('معاينة الطالب', 'سيتم فتح نافذة محاكاة اختبار الطالب.');
                },
                icon: const Icon(Icons.visibility_outlined, color: primaryColor, size: 16),
                label: Text(
                  'عرض كطالب',
                  style: GoogleFonts.notoKufiArabic(
                    color: primaryColor,
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFDBEAFE)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Edit button
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => controller.prevStep(), // Go back to settings/details
                icon: const Icon(Icons.edit_outlined, color: primaryColor, size: 16),
                label: Text(
                  'تعديل',
                  style: GoogleFonts.notoKufiArabic(
                    color: primaryColor,
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFDBEAFE)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Card 1: Exam Date/Schedule (موعد الاختبار)
        _buildReviewCard(
          icon: Icons.calendar_month_outlined,
          iconBgColor: const Color(0xFFEFF6FF),
          iconColor: primaryColor,
          title: 'موعد الاختبار',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '15 أكتوبر 2023',
                style: GoogleFonts.notoKufiArabic(fontSize: 13, fontWeight: FontWeight.bold, color: textDark),
              ),
              const SizedBox(height: 2),
              Text(
                '09:00 صباحاً - 11:00 صباحاً',
                style: GoogleFonts.notoKufiArabic(fontSize: 11, color: const Color(0xFF64748B)),
              ),
            ],
          ),
        ),

        // Card 2: Duration (المدة الزمنية)
        _buildReviewCard(
          icon: Icons.timer_outlined,
          iconBgColor: const Color(0xFFECFDF5),
          iconColor: const Color(0xFF10B981),
          title: 'المدة الزمنية',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${controller.durationMinutes.value} دقيقة',
                style: GoogleFonts.notoKufiArabic(fontSize: 13, fontWeight: FontWeight.bold, color: textDark),
              ),
              const SizedBox(height: 2),
              Text(
                'مدة الحل المسموحة',
                style: GoogleFonts.notoKufiArabic(fontSize: 11, color: const Color(0xFF64748B)),
              ),
            ],
          ),
        ),

        // Card 3: Structure (هيكل الاختبار)
        _buildReviewCard(
          icon: Icons.assignment_outlined,
          iconBgColor: const Color(0xFFFFF7ED),
          iconColor: const Color(0xFFD97706),
          title: 'هيكل الاختبار',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildStructureItem('25 سؤال كلي'),
              _buildStructureItem('15 اختيار متعدد'),
              _buildStructureItem('5 مقالي'),
              _buildStructureItem('100 درجة كلية'),
            ],
          ),
        ),

        // Card 4: Security (إعدادات الأمان)
        _buildReviewCard(
          icon: Icons.shield_outlined,
          iconBgColor: const Color(0xFFF1F5F9),
          iconColor: const Color(0xFF475569),
          title: 'إعدادات الأمان',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildSecurityStatus('متصفح آمن (Lockdown)', true),
              _buildSecurityStatus('ترتيب عشوائي للأسئلة', true),
              _buildSecurityStatus('مراقبة بالكاميرا', false),
            ],
          ),
        ),

        // Card 5: Target Audience (الجمهور المستهدف)
        _buildReviewCard(
          icon: Icons.groups_outlined,
          iconBgColor: const Color(0xFFFAF5FF),
          iconColor: const Color(0xFFA855F7),
          title: 'الجمهور المستهدف',
          body: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.end,
            children: [
              _buildBadge(controller.selectedGradeLevel.value),
              _buildBadge('المسار العلمي'),
              _buildBadge('+140 طالب'),
            ],
          ),
        ),

        // Card 6: Cover image banner
        Container(
          height: 120,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            image: const DecorationImage(
              image: AssetImage('assets/images/cover_placeholder.png'), // mock cover image
              fit: BoxFit.cover,
              onError: null,
            ),
            color: const Color(0xFF1E293B),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: Text(
              'سيتم عرض هذا الغلاف للطلاب عند الدخول للاختبار',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoKufiArabic(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Wizard Actions: حفظ ونشر & السابق
        Row(
          children: [
            // Outlined Back Button
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.prevStep(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'السابق',
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 13,
                    color: const Color(0xFF475569),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Save and Publish Button
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.saveCurrentExamWizard(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'حفظ ونشر',
                  style: GoogleFonts.notoKufiArabic(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required Widget body,
  }) {
    const textDark = Color(0xFF1E293B);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          body,
        ],
      ),
    );
  }

  Widget _buildStructureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: GoogleFonts.notoKufiArabic(fontSize: 11, color: const Color(0xFF475569)),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.circle, size: 5, color: Color(0xFFCBD5E1)),
        ],
      ),
    );
  }

  Widget _buildSecurityStatus(String label, bool isEnabled) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isEnabled ? 'مفعّل' : 'معطّل',
            style: GoogleFonts.notoKufiArabic(
              fontSize: 11,
              color: isEnabled ? const Color(0xFF10B981) : const Color(0xFF94A3B8),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.notoKufiArabic(fontSize: 11, color: const Color(0xFF475569)),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.notoKufiArabic(fontSize: 10, color: const Color(0xFF475569)),
      ),
    );
  }
}

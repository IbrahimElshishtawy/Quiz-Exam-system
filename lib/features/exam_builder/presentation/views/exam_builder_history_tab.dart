import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamBuilderHistoryTab extends StatelessWidget {
  const ExamBuilderHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'سجل العمليات والنشاطات',
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildTimelineItem(
              time: 'منذ 5 دقائق',
              title: 'بلاغ عن حالة غش محتملة',
              desc: 'تم رصد محاولة تبديل نوافذ في قاعة 4 للطالب أحمد محمد.',
              icon: Icons.warning_amber_rounded,
              iconColor: Colors.redAccent,
              bgColor: const Color(0xFFFFF1F2),
            ),
            _buildTimelineItem(
              time: 'منذ 15 دقيقة',
              title: 'اكتمل تصحيح الأوراق تلقائياً',
              desc: 'تم انتهاء تصحيح 20 ورقة إجابة لاختبار مادة الكيمياء العامة.',
              icon: Icons.check_circle_outline,
              iconColor: const Color(0xFF10B981),
              bgColor: const Color(0xFFECFDF5),
            ),
            _buildTimelineItem(
              time: 'منذ ساعة',
              title: 'انضمام طالب جديد لقاعة الفيزياء',
              desc: 'قام الطالب عمر العتيبي بالتسجيل ودخول قاعة اختبار الفيزياء.',
              icon: Icons.person_add_outlined,
              iconColor: primaryColor,
              bgColor: const Color(0xFFEFF6FF),
            ),
            _buildTimelineItem(
              time: 'منذ ساعتين',
              title: 'حفظ مسودة اختبار جديدة',
              desc: 'تم حفظ مسودة "اختبار الكيمياء الشهري" بنجاح.',
              icon: Icons.save_as_outlined,
              iconColor: const Color(0xFFD97706),
              bgColor: const Color(0xFFFFF7ED),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String desc,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    const textDark = Color(0xFF1E293B);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: GoogleFonts.notoKufiArabic(fontSize: 9.5, color: const Color(0xFF94A3B8)),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.notoKufiArabic(fontSize: 12.5, fontWeight: FontWeight.bold, color: textDark),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.notoKufiArabic(fontSize: 10.5, color: const Color(0xFF64748B), height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Right visual timeline node
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              Container(
                width: 2,
                height: 50,
                color: const Color(0xFFE2E8F0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentActivityListWidget extends StatelessWidget {
  const RecentActivityListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    final List<ActivityItem> activities = [
      ActivityItem(
        title: 'تم إكمال اختبار الحاسب الذكي',
        subtitle: 'النتيجة: 95/100',
        icon: Icons.check_circle_rounded,
        iconColor: const Color(0xFF10B981),
        bgColor: const Color(0xFFD1FAE5),
      ),
      ActivityItem(
        title: 'إضافة مادة التقييم العضوي',
        subtitle: 'تمت الإضافة للمنهج الدراسي المعتمد',
        icon: Icons.school_rounded,
        iconColor: primaryColor,
        bgColor: const Color(0xFFDBEAFE),
      ),
      ActivityItem(
        title: 'فشل في محاولة تقديم ملف',
        subtitle: 'فشل رفع تقرير الواجب، حاول مرة أخرى',
        icon: Icons.warning_rounded,
        iconColor: const Color(0xFFEF4444),
        bgColor: const Color(0xFFFEE2E2),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Map activities to rows
        ...activities.map((act) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: act.bgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(act.icon, color: act.iconColor, size: 20),
                  ),
                  const SizedBox(width: 14),

                  // Text Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          act.title,
                          style: GoogleFonts.notoKufiArabic(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          act.subtitle,
                          style: GoogleFonts.notoKufiArabic(
                            fontSize: 10,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 8),

        // Bottom view all button
        Center(
          child: TextButton(
            onPressed: () {
              Get.snackbar(
                'الأنشطة السابقة',
                'هذه الميزة تعرض سجل نشاطك الأكاديمي الكامل.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                colorText: primaryColor,
              );
            },
            child: Text(
              'عرض جميع الأنشطة',
              style: GoogleFonts.notoKufiArabic(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ActivityItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  ActivityItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });
}

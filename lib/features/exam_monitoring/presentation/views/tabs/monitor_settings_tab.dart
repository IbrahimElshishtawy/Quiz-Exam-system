import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonitorSettingsTab extends StatefulWidget {
  const MonitorSettingsTab({super.key});

  @override
  State<MonitorSettingsTab> createState() => _MonitorSettingsTabState();
}

class _MonitorSettingsTabState extends State<MonitorSettingsTab> {
  bool faceVerification = true;
  bool tabSwitchLock = true;
  bool micRecording = true;
  bool eyeTracking = false;
  bool secureBrowser = true;

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    Widget buildSettingSwitch(String title, String description, bool val, ValueChanged<bool> onChanged) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Switch.adaptive(
              value: val,
              onChanged: onChanged,
              activeColor: primaryColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    textAlign: TextAlign.right,
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
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 12),
          child: Text(
            'إعدادات المراقبة والذكاء الاصطناعي',
            textAlign: TextAlign.right,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
        ),
        buildSettingSwitch(
          'التحقق من الوجه والهوية (AI)',
          'تأكيد هوية الطالب طوال فترة الاختبار ومنع انتحال الشخصية.',
          faceVerification,
          (v) => setState(() => faceVerification = v),
        ),
        buildSettingSwitch(
          'قفل النوافذ والتبويبات (Tab-Lock)',
          'تنبيه الطالب وتسجيل مخالفة فور خروجه من متصفح أو تطبيق الاختبار.',
          tabSwitchLock,
          (v) => setState(() => tabSwitchLock = v),
        ),
        buildSettingSwitch(
          'تحليل الأصوات والضوضاء المحيطة',
          'رصد الكلام والضجيج في خلفية الطالب باستخدام الميكروفون.',
          micRecording,
          (v) => setState(() => micRecording = v),
        ),
        buildSettingSwitch(
          'تتبع حركة العين والتركيز (Eye-Tracking)',
          'رصد اتجاه نظر الطالب وتنبيهه عند التشتت المتكرر خارج الشاشة.',
          eyeTracking,
          (v) => setState(() => eyeTracking = v),
        ),
        buildSettingSwitch(
          'المتصفح الآمن والمقفل (Secure Browser)',
          'منع تصوير الشاشة أو نسخ ولصق النصوص والوصول لتبويبات أخرى.',
          secureBrowser,
          (v) => setState(() => secureBrowser = v),
        ),
      ],
    );
  }
}

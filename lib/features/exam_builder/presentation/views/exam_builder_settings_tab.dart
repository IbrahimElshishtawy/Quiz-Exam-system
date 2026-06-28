import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExamBuilderSettingsTab extends StatelessWidget {
  const ExamBuilderSettingsTab({super.key});

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
          'إعدادات منشئ الاختبارات',
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
            // Header
            Text(
              'الخصائص الافتراضية للذكاء الاصطناعي',
              textAlign: TextAlign.right,
              style: GoogleFonts.notoKufiArabic(fontSize: 13, fontWeight: FontWeight.bold, color: textDark),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildMenuItem(Icons.auto_awesome_outlined, 'مستوى صعوبة الأسئلة الافتراضي', 'متوسط'),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  _buildMenuItem(Icons.shield_outlined, 'مراقبة الذكاء الاصطناعي الافتراضية', 'مفعّلة بالكامل'),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  _buildMenuItem(Icons.timer_outlined, 'مدة الاختبار التلقائية', '60 دقيقة'),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Shuffling defaults
            Text(
              'تفضيلات المزامنة والأمان',
              textAlign: TextAlign.right,
              style: GoogleFonts.notoKufiArabic(fontSize: 13, fontWeight: FontWeight.bold, color: textDark),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildSwitchItem(Icons.shuffle, 'تفعيل عشوائية الأسئلة تلقائياً', true),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  _buildSwitchItem(Icons.devices_other_rounded, 'تفعيل الحماية بمتصفح آمن دائماً', true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String value) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return ListTile(
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFEFF6FF),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: primaryColor, size: 18),
      ),
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: GoogleFonts.notoKufiArabic(fontSize: 12, fontWeight: FontWeight.bold, color: textDark),
      ),
      subtitle: Text(
        value,
        textAlign: TextAlign.right,
        style: GoogleFonts.notoKufiArabic(fontSize: 10, color: primaryColor, fontWeight: FontWeight.bold),
      ),
      leading: const Icon(Icons.chevron_left_rounded, color: Color(0xFF94A3B8)),
    );
  }

  Widget _buildSwitchItem(IconData icon, String title, bool isChecked) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return ListTile(
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFEFF6FF),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: primaryColor, size: 18),
      ),
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: GoogleFonts.notoKufiArabic(fontSize: 12, fontWeight: FontWeight.bold, color: textDark),
      ),
      leading: Switch.adaptive(
        value: isChecked,
        onChanged: (_) {},
        activeColor: primaryColor,
      ),
    );
  }
}

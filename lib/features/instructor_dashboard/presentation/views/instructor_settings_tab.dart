import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../controllers/instructor_dashboard_controller.dart';

class InstructorSettingsTab extends GetView<InstructorDashboardController> {
  const InstructorSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'الإعدادات',
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 16,
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
              // 1. Profile Picture and Header
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: primaryColor, width: 2.5),
                          ),
                          child: const CircleAvatar(
                            radius: 54,
                            backgroundColor: Color(0xFFF1F5F9),
                            backgroundImage: null, // Portrait avatar placeholder
                            child: Icon(Icons.person, size: 54, color: Color(0xFF64748B)),
                          ),
                        ),
                        // Edit icon badge
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, color: Colors.white, size: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Full Name
                    Text(
                      'أ. سارة المنصور',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle
                    Text(
                      'معلمة أولى - الرياضيات المتقدمة',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Green verification badge: "حساب معتمد"
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5), // soft green
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'حساب معتمد',
                            style: GoogleFonts.notoKufiArabic(
                              color: const Color(0xFF047857),
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Stats Summary Row (850 Active Students, 4.9 Rating)
              Row(
                children: [
                  // Performance Rating Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '4.9',
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'تقييم الأداء',
                            style: GoogleFonts.notoKufiArabic(
                              fontSize: 10.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Active Students Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '850',
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'طالب نشط',
                            style: GoogleFonts.notoKufiArabic(
                              fontSize: 10.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // 3. "الأمان والحساب" Section Header
              Text(
                'الأمان والحساب',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 12),

              // Menu Items Box
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.shield_outlined, 'أمن الحساب'),
                    const Divider(color: Color(0xFFE2E8F0), height: 1),
                    _buildMenuItem(
                      Icons.translate_rounded,
                      'لغة التطبيق',
                      subtitle: 'العربية',
                      onTap: () => Get.toNamed(Routes.WELCOME_SETUP),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4. "تفضيلات التطبيق" Section Header
              Text(
                'تفضيلات التطبيق',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 12),

              // Switched Items Box
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Exam Notifications Switch
                    Obx(() => _buildSwitchItem(
                          Icons.notifications_active_outlined,
                          'تنبيهات الاختبارات',
                          controller.examNotificationsEnabled.value,
                          (val) => controller.examNotificationsEnabled.value = val,
                        )),
                    const Divider(color: Color(0xFFE2E8F0), height: 1),
                    // Dark mode switch
                    Obx(() => _buildSwitchItem(
                          Icons.dark_mode_outlined,
                          'الوضع الليلي',
                          controller.darkModeEnabled.value,
                          (val) => controller.darkModeEnabled.value = val,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // 5. Logout Button
              SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final box = GetStorage();
                    await box.remove('user_role');
                    Get.offAllNamed(Routes.WELCOME_GATEWAY);
                  },
                  icon: const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 20),
                  label: Text(
                    'تسجيل الخروج',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF1F2), // rose red bg
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {String? subtitle, VoidCallback? onTap}) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return ListTile(
      onTap: onTap ?? () => Get.snackbar('تنبيه', 'هذه الميزة غير متوفرة في النسخة التجريبية حالياً.'),
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFEFF6FF),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: primaryColor, size: 20),
      ),
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: GoogleFonts.notoKufiArabic(
          fontSize: 12.5,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              textAlign: TextAlign.right,
              style: GoogleFonts.notoKufiArabic(
                fontSize: 10,
                color: const Color(0xFF64748B),
              ),
            )
          : null,
      leading: const Icon(Icons.chevron_left_rounded, color: Color(0xFF94A3B8)),
    );
  }

  Widget _buildSwitchItem(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return ListTile(
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFEFF6FF),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: primaryColor, size: 20),
      ),
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: GoogleFonts.notoKufiArabic(
          fontSize: 12.5,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
      ),
      leading: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
      ),
    );
  }
}

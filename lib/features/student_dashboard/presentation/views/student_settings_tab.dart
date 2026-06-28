import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';

class StudentSettingsTab extends StatelessWidget {
  const StudentSettingsTab({super.key});

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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // User Profile Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'أحمد محمد',
                          style: GoogleFonts.notoKufiArabic(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ahmed.student@eduassess.ai',
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 12,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: primaryColor,
                      child: Icon(Icons.person, color: Colors.white, size: 36),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Settings Menu options
              _buildMenuItem(Icons.edit_outlined, 'تعديل الملف الشخصي'),
              _buildMenuItem(Icons.lock_outline_rounded, 'تغيير كلمة المرور'),
              
              // Dynamic link to language/role selection screen
              Obx(() {
                final settingsController = Get.find<SettingsController>();
                final isAr = settingsController.languageCode.value == 'ar';
                return _buildMenuItem(
                  Icons.language_rounded,
                  'language'.tr,
                  subtitle: isAr ? 'العربية' : 'English',
                  onTap: () {
                    if (isAr) {
                      settingsController.changeLanguage('en');
                    } else {
                      settingsController.changeLanguage('ar');
                    }
                  },
                );
              }),
              
              // Dark mode switch
              Obx(() {
                final settingsController = Get.find<SettingsController>();
                return _buildSwitchItem(
                  Icons.dark_mode_outlined,
                  'darkMode'.tr,
                  settingsController.isDarkMode.value,
                  (val) => settingsController.toggleTheme(val),
                );
              }),
              
              _buildMenuItem(Icons.info_outline_rounded, 'حول التطبيق'),
              const SizedBox(height: 24),

              // Logout Button
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
                    backgroundColor: const Color(0xFFFEE2E2),
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
    final isRtl = Get.locale?.languageCode == 'ar';
    const textDark = Color(0xFF1E293B);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap ?? () => Get.snackbar('alert'.tr, 'not_available_demo'.tr),
        leading: isRtl 
            ? const Icon(Icons.chevron_left_rounded, color: Color(0xFF94A3B8))
            : Icon(icon, color: const Color(0xFF64748B)),
        trailing: isRtl
            ? Icon(icon, color: const Color(0xFF64748B))
            : const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
        title: Text(
          title,
          textAlign: isRtl ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                textAlign: isRtl ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 10.5,
                  color: const Color(0xFF64748B),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildSwitchItem(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    final isRtl = Get.locale?.languageCode == 'ar';
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: isRtl
            ? Switch.adaptive(
                value: value,
                onChanged: onChanged,
                activeColor: primaryColor,
              )
            : Icon(icon, color: const Color(0xFF64748B)),
        trailing: isRtl
            ? Icon(icon, color: const Color(0xFF64748B))
            : Switch.adaptive(
                value: value,
                onChanged: onChanged,
                activeColor: primaryColor,
              ),
        title: Text(
          title,
          textAlign: isRtl ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/student_dashboard_controller.dart';

class JoinExamBannerWidget extends GetView<StudentDashboardController> {
  const JoinExamBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        gradient: const LinearGradient(
          colors: [primaryColor, Color(0xFF1E3A8A)], // Deep blue gradient
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner Title
          Text(
            'انضم إلى اختبار الآن',
            textAlign: TextAlign.right,
            style: GoogleFonts.notoKufiArabic(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          
          // Banner Subtitle
          Text(
            'أدخل رمز الجلسة المكون من 6 أرقام أو امسح رمز الاستجابة السريعة (QR Code).',
            textAlign: TextAlign.right,
            style: GoogleFonts.notoKufiArabic(
              color: Colors.white.withOpacity(0.85),
              fontSize: 11,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),

          // Session Code Input Field with "انضم" Button
          Container(
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
            ),
            child: Row(
              children: [
                // Join Button
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                    height: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.joinExamSession(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: Text(
                        'انضم',
                        style: GoogleFonts.notoKufiArabic(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // Text Input
                Expanded(
                  child: TextField(
                    controller: controller.sessionCodeController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.ibmPlexSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'رقم الجلسة',
                      hintStyle: GoogleFonts.notoKufiArabic(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // QR Scanner & AI Helper Buttons Row
          Row(
            children: [
              // AI Helper Button
              Expanded(
                child: InkWell(
                  onTap: () {
                    // Navigate to AI Assistant tab
                    controller.currentTabIndex.value = 2;
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'مساعد الذكاء',
                          style: GoogleFonts.notoKufiArabic(
                            color: Colors.white,
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

              // QR Scanner Button
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.snackbar(
                      'ماسح الاستجابة السريعة',
                      'سيتم فتح كاميرا الهاتف لمسح رمز QR الخاص بالاختبار.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.white,
                      colorText: primaryColor,
                    );
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'ماسح QR',
                          style: GoogleFonts.notoKufiArabic(
                            color: Colors.white,
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
        ],
      ),
    );
  }
}

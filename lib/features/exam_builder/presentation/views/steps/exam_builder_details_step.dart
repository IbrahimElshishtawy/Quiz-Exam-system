import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/exam_builder_controller.dart';

class ExamBuilderDetailsStep extends GetView<ExamBuilderController> {
  const ExamBuilderDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    final List<String> subjects = ['الفيزياء المتقدمة', 'الكيمياء العامة', 'الرياضيات', 'علم الأحياء'];
    final List<String> gradeLevels = ['الصف الأول الثانوي', 'الصف الثاني الثانوي', 'الصف الثالث الثانوي'];

    return Form(
      key: controller.detailsFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header titles
          Text(
            'بيانات الاختبار الأساسية',
            textAlign: TextAlign.right,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'أدخل المعلومات الأساسية للبدء في بناء الاختبار الجديد.',
            textAlign: TextAlign.right,
            style: GoogleFonts.notoKufiArabic(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 24),

          // Title input: "عنوان الاختبار"
          _buildFieldLabel('عنوان الاختبار'),
          TextFormField(
            controller: controller.titleCtrl,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: GoogleFonts.notoKufiArabic(fontSize: 12.5),
            decoration: InputDecoration(
              hintText: 'مثال: اختبار الشهر الأول - العلوم',
              hintStyle: GoogleFonts.notoKufiArabic(color: const Color(0xFF94A3B8), fontSize: 12),
              prefixIcon: const Icon(Icons.edit_note_rounded, color: Color(0xFF94A3B8)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: primaryColor, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'يرجى إدخال عنوان الاختبار';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),

          // Subject dropdown: "المادة الدراسية"
          _buildFieldLabel('المادة الدراسية'),
          Obx(() => _buildDropdown(
                subjects,
                controller.selectedSubject.value,
                (val) => controller.selectedSubject.value = val!,
                Icons.menu_book_rounded,
              )),
          const SizedBox(height: 18),

          // Level dropdown: "المستوى الدراسي"
          _buildFieldLabel('المستوى الدراسي'),
          Obx(() => _buildDropdown(
                gradeLevels,
                controller.selectedGradeLevel.value,
                (val) => controller.selectedGradeLevel.value = val!,
                Icons.school_outlined,
              )),
          const SizedBox(height: 18),

          // Description input: "وصف الاختبار (اختياري)"
          _buildFieldLabel('وصف الاختبار (اختياري)'),
          TextFormField(
            controller: controller.descCtrl,
            maxLines: 4,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: GoogleFonts.notoKufiArabic(fontSize: 12.5),
            decoration: InputDecoration(
              hintText: 'اكتب وصفاً موجزاً للطلاب حول محتوى الاختبار وأهدافه...',
              hintStyle: GoogleFonts.notoKufiArabic(color: const Color(0xFF94A3B8), fontSize: 11.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: primaryColor, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          const SizedBox(height: 20),

          // Cover upload dotted area: "أضف غلافاً للاختبار"
          _buildFieldLabel('أضف غلافاً للاختبار (اختياري)'),
          InkWell(
            onTap: () {
              // Simulation of uploading image file
              controller.coverImage.value = 'mock_path_cover.png';
              Get.snackbar('تحميل الغلاف', 'تم رفع غلاف الاختبار بنجاح.');
            },
            borderRadius: BorderRadius.circular(16),
            child: Obx(() {
              final hasImage = controller.coverImage.value.isNotEmpty;

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: hasImage ? primaryColor : const Color(0xFFCBD5E1),
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      hasImage ? Icons.image_rounded : Icons.add_photo_alternate_outlined,
                      color: hasImage ? primaryColor : const Color(0xFF94A3B8),
                      size: 34,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      hasImage ? 'تم إضافة صورة الغلاف' : 'أضف غلافاً للاختبار',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: hasImage ? primaryColor : textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'اسحب الصورة هنا أو انقر للتحميل (PNG, JPG)',
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 10,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 32),

          // Next navigation button (pointed left in RTL)
          SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: () => controller.nextStep(),
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              label: Text(
                'التالي',
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        textAlign: TextAlign.right,
        style: GoogleFonts.notoKufiArabic(
          fontSize: 11.5,
          color: const Color(0xFF475569),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDropdown(
    List<String> items,
    String value,
    ValueChanged<String?> onChanged,
    IconData prefixIcon,
  ) {
    const primaryColor = Color(0xFF005BBF);

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.expand_more_rounded, color: Color(0xFF64748B)),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                onChanged: onChanged,
                isExpanded: true,
                alignment: Alignment.centerRight,
                items: items
                    .map((it) => DropdownMenuItem<String>(
                          value: it,
                          child: Text(
                            it,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.notoKufiArabic(fontSize: 12),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(prefixIcon, color: const Color(0xFF94A3B8), size: 20),
        ],
      ),
    );
  }
}

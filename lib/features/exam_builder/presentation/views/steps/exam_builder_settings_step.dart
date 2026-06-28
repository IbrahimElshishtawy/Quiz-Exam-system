import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/exam_builder_controller.dart';

class ExamBuilderSettingsStep extends GetView<ExamBuilderController> {
  const ExamBuilderSettingsStep({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title & Header
        Text(
          'إعدادات الاختبار والجدولة',
          textAlign: TextAlign.right,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'قم بضبط الخصائص الفنية والزمنية للاختبار النهائي لمادة "الفيزياء المتقدمة"',
          textAlign: TextAlign.right,
          style: GoogleFonts.notoKufiArabic(
            fontSize: 11,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 24),

        // Section 1: Duration & Access
        _buildSectionHeader(Icons.timer_outlined, 'المدة والدخول'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Duration field
              _buildFieldLabel('مدة الاختبار (بالدقائق)'),
              TextFormField(
                initialValue: '${controller.durationMinutes.value}',
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                style: GoogleFonts.ibmPlexSans(fontSize: 13, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  suffixText: 'دقيقة',
                  suffixStyle: GoogleFonts.notoKufiArabic(fontSize: 11, color: const Color(0xFF64748B)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                onChanged: (val) {
                  final num = int.tryParse(val);
                  if (num != null) controller.durationMinutes.value = num;
                },
              ),
              const SizedBox(height: 16),

              // Password Switch
              Obx(() => _buildSwitchTile(
                    'حماية بكلمة مرور',
                    'تطلب من الطالب قبل البدء',
                    controller.hasPassword.value,
                    (val) => controller.hasPassword.value = val,
                  )),

              if (controller.hasPassword.value) ...[
                const SizedBox(height: 10),
                TextFormField(
                  textAlign: TextAlign.right,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'أدخل كلمة مرور الاختبار',
                    hintStyle: GoogleFonts.notoKufiArabic(fontSize: 11),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  ),
                ),
              ],
              const SizedBox(height: 16),

              // Attempt Limit dropdown
              _buildFieldLabel('عدد المحاولات المسموح بها'),
              _buildDropdown(
                ['محاولة واحدة فقط', 'محاولتان', '3 محاولات', 'غير محدود'],
                controller.allowedAttempts.value,
                (val) => controller.allowedAttempts.value = val!,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Section 2: Publish Schedule (جدولة النشر)
        _buildSectionHeader(Icons.calendar_today_outlined, 'جدولة النشر'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Start & End dates
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildFieldLabel('تاريخ الانتهاء'),
                        Obx(() => _buildDatePickerButton(
                              context,
                              controller.endDate.value,
                              (d) => controller.endDate.value = d,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildFieldLabel('تاريخ البدء'),
                        Obx(() => _buildDatePickerButton(
                              context,
                              controller.startDate.value,
                              (d) => controller.startDate.value = d,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Open & Close times
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildFieldLabel('وقت الإغلاق'),
                        Obx(() => _buildTimePickerButton(
                              context,
                              controller.closeTime.value,
                              (t) => controller.closeTime.value = t,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildFieldLabel('وقت الفتح'),
                        Obx(() => _buildTimePickerButton(
                              context,
                              controller.openTime.value,
                              (t) => controller.openTime.value = t,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Visibility: "ظهور الاختبار"
              _buildFieldLabel('ظهور الاختبار'),
              Obx(() => Row(
                    children: [
                      // Private Mode button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => controller.isPublic.value = false,
                          icon: Icon(
                            Icons.lock_outline,
                            color: !controller.isPublic.value ? primaryColor : const Color(0xFF64748B),
                            size: 16,
                          ),
                          label: Text(
                            'خاص',
                            style: GoogleFonts.notoKufiArabic(
                              color: !controller.isPublic.value ? primaryColor : const Color(0xFF64748B),
                              fontSize: 11.5,
                              fontWeight: !controller.isPublic.value ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: !controller.isPublic.value ? primaryColor : const Color(0xFFCBD5E1),
                              width: !controller.isPublic.value ? 1.5 : 1,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Public Mode button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => controller.isPublic.value = true,
                          icon: Icon(
                            Icons.public,
                            color: controller.isPublic.value ? primaryColor : const Color(0xFF64748B),
                            size: 16,
                          ),
                          label: Text(
                            'عام',
                            style: GoogleFonts.notoKufiArabic(
                              color: controller.isPublic.value ? primaryColor : const Color(0xFF64748B),
                              fontSize: 11.5,
                              fontWeight: controller.isPublic.value ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: controller.isPublic.value ? primaryColor : const Color(0xFFCBD5E1),
                              width: controller.isPublic.value ? 1.5 : 1,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Section 3: Shuffling & Randomization (Blue container banner)
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [primaryColor, Color(0xFF1E4ED8)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'تخصيص التجربة والعشوائية',
                    style: GoogleFonts.notoKufiArabic(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.shuffle, color: Colors.white, size: 18),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'قم بتفعيل ميزات العشوائية لضمان نزاهة الاختبار وتقليل فرص التداخل بين الطلاب.',
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 10,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),

              // Switch 1: Question Shuffle
              Obx(() => _buildBlueSwitchTile(
                    'عشوائية ترتيب الأسئلة',
                    controller.shuffleQuestions.value,
                    (val) => controller.shuffleQuestions.value = val,
                  )),

              // Switch 2: Option Shuffle
              Obx(() => _buildBlueSwitchTile(
                    'عشوائية ترتيب الخيارات',
                    controller.shuffleOptions.value,
                    (val) => controller.shuffleOptions.value = val,
                  )),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Navigation Actions: التالي & السابق
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

            // Blue Proceed Button
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.nextStep(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'التالي',
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

  Widget _buildSectionHeader(IconData icon, String title) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
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
          Icon(icon, color: primaryColor, size: 18),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0, top: 4),
      child: Text(
        label,
        textAlign: TextAlign.right,
        style: GoogleFonts.notoKufiArabic(
          fontSize: 11,
          color: const Color(0xFF64748B),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String sub, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: GoogleFonts.notoKufiArabic(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        sub,
        textAlign: TextAlign.right,
        style: GoogleFonts.notoKufiArabic(fontSize: 10, color: const Color(0xFF64748B)),
      ),
      contentPadding: EdgeInsets.zero,
      activeColor: const Color(0xFF005BBF),
    );
  }

  Widget _buildBlueSwitchTile(String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: const Color(0xFF60A5FA),
        ),
        Text(
          title,
          style: GoogleFonts.notoKufiArabic(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(List<String> items, String value, ValueChanged<String?> onChanged) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          icon: const Icon(Icons.expand_more_rounded, color: Color(0xFF64748B)),
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
    );
  }

  Widget _buildDatePickerButton(BuildContext context, DateTime date, ValueChanged<DateTime> onPicked) {
    return InkWell(
      onTap: () async {
        final d = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
        );
        if (d != null) onPicked(d);
      },
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCBD5E1)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.calendar_month, size: 18, color: Color(0xFF64748B)),
            Text(
              '${date.year}/${date.month}/${date.day}',
              style: GoogleFonts.ibmPlexSans(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePickerButton(BuildContext context, TimeOfDay time, ValueChanged<TimeOfDay> onPicked) {
    return InkWell(
      onTap: () async {
        final t = await showTimePicker(context: context, initialTime: time);
        if (t != null) onPicked(t);
      },
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCBD5E1)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.access_time_rounded, size: 18, color: Color(0xFF64748B)),
            Text(
              time.format(context),
              style: GoogleFonts.ibmPlexSans(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

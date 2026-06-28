import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/student_dashboard_controller.dart';

class CustomCalendarWidget extends GetView<StudentDashboardController> {
  const CustomCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDark = Color(0xFF1E293B);

    // Days of the week in Arabic, ordered from right to left (RTL)
    final List<String> weekDays = ['سبت', 'جمعة', 'خميس', 'أربعاء', 'ثلاثاء', 'اثنين', 'أحد'];

    // September 2024 Calendar representation: starts from Aug 28 to Sept 24 as in mockup
    // Let's create an array of DateTime objects for this grid
    final List<CalendarDayModel> days = [
      // August overflow
      CalendarDayModel(date: DateTime(2024, 8, 28), isCurrentMonth: false, label: '28'),
      CalendarDayModel(date: DateTime(2024, 8, 29), isCurrentMonth: false, label: '29'),
      CalendarDayModel(date: DateTime(2024, 8, 30), isCurrentMonth: false, label: '30'),
      CalendarDayModel(date: DateTime(2024, 8, 31), isCurrentMonth: false, label: '31'),
      
      // September
      CalendarDayModel(date: DateTime(2024, 9, 1), isCurrentMonth: true, label: '1'),
      CalendarDayModel(date: DateTime(2024, 9, 2), isCurrentMonth: true, label: '2'),
      CalendarDayModel(date: DateTime(2024, 9, 3), isCurrentMonth: true, label: '3'),
      CalendarDayModel(date: DateTime(2024, 9, 4), isCurrentMonth: true, label: '4'),
      CalendarDayModel(date: DateTime(2024, 9, 5), isCurrentMonth: true, label: '5'),
      CalendarDayModel(date: DateTime(2024, 9, 6), isCurrentMonth: true, label: '6'),
      CalendarDayModel(date: DateTime(2024, 9, 7), isCurrentMonth: true, label: '7'),
      CalendarDayModel(date: DateTime(2024, 9, 8), isCurrentMonth: true, label: '8'),
      CalendarDayModel(date: DateTime(2024, 9, 9), isCurrentMonth: true, label: '9'),
      CalendarDayModel(date: DateTime(2024, 9, 10), isCurrentMonth: true, label: '10'),
      CalendarDayModel(date: DateTime(2024, 9, 11), isCurrentMonth: true, label: '11'),
      CalendarDayModel(date: DateTime(2024, 9, 12), isCurrentMonth: true, label: '12'),
      CalendarDayModel(date: DateTime(2024, 9, 13), isCurrentMonth: true, label: '13'),
      CalendarDayModel(date: DateTime(2024, 9, 14), isCurrentMonth: true, label: '14'),
      CalendarDayModel(date: DateTime(2024, 9, 15), isCurrentMonth: true, label: '15'),
      CalendarDayModel(date: DateTime(2024, 9, 16), isCurrentMonth: true, label: '16'),
      CalendarDayModel(date: DateTime(2024, 9, 17), isCurrentMonth: true, label: '17'),
      CalendarDayModel(date: DateTime(2024, 9, 18), isCurrentMonth: true, label: '18'),
      CalendarDayModel(date: DateTime(2024, 9, 19), isCurrentMonth: true, label: '19'),
      CalendarDayModel(date: DateTime(2024, 9, 20), isCurrentMonth: true, label: '20'),
      CalendarDayModel(date: DateTime(2024, 9, 21), isCurrentMonth: true, label: '21'),
      CalendarDayModel(date: DateTime(2024, 9, 22), isCurrentMonth: true, label: '22'),
      CalendarDayModel(date: DateTime(2024, 9, 23), isCurrentMonth: true, label: '23'),
      CalendarDayModel(date: DateTime(2024, 9, 24), isCurrentMonth: true, label: '24'),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header: Date & Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Navigation buttons
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: Color(0xFF64748B)),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, color: Color(0xFF64748B)),
                    onPressed: () {},
                  ),
                ],
              ),
              
              // Title text
              Text(
                'سبتمبر 2024',
                style: GoogleFonts.notoKufiArabic(
                  color: textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Weekdays row (سبت، جمعة، خميس، الخ)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDays
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: GoogleFonts.notoKufiArabic(
                            color: const Color(0xFF64748B),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),

          // Days Grid (7 columns as week format)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final CalendarDayModel day = days[index];
              
              return Obx(() {
                final bool isSelected = controller.selectedDate.value.day == day.date.day &&
                    controller.selectedDate.value.month == day.date.month;
                final bool hasTasks = controller.dateHasTasks(day.date);

                return GestureDetector(
                  onTap: () => controller.selectDate(day.date),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.label,
                          style: GoogleFonts.ibmPlexSans(
                            color: isSelected
                                ? Colors.white
                                : day.isCurrentMonth
                                    ? textDark
                                    : const Color(0xFFCBD5E1),
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        // Small blue dot if day has tasks (and is not selected)
                        if (hasTasks)
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : primaryColor,
                              shape: BoxShape.circle,
                            ),
                          )
                        else
                          const SizedBox(height: 6),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}

class CalendarDayModel {
  final DateTime date;
  final bool isCurrentMonth;
  final String label;

  CalendarDayModel({
    required this.date,
    required this.isCurrentMonth,
    required this.label,
  });
}

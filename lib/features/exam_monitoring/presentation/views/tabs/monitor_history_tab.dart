import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonitorHistoryTab extends StatelessWidget {
  const MonitorHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    // Mock history items
    final historyItems = [
      _HistoryItem(title: 'اختبار العلوم النهائي', date: 'اليوم، 09:30 ص', status: 'جاري الآن', studentsCount: 124, integrityScore: 92, isActive: true),
      _HistoryItem(title: 'اختبار الكيمياء الشهري', date: 'أمس، 11:00 ص', status: 'مكتمل', studentsCount: 118, integrityScore: 95, isActive: false),
      _HistoryItem(title: 'اختبار تجريبي: الفيزياء', date: '25 يونيو 2026', status: 'مكتمل', studentsCount: 140, integrityScore: 98, isActive: false),
      _HistoryItem(title: 'اختبار الأحياء القصير 2', date: '18 يونيو 2026', status: 'مكتمل', studentsCount: 115, integrityScore: 89, isActive: false),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: historyItems.length,
      itemBuilder: (context, idx) {
        final item = historyItems[idx];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.01),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row 1: Title and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: item.isActive ? const Color(0xFFECFDF5) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.status,
                      style: GoogleFonts.notoKufiArabic(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: item.isActive ? const Color(0xFF10B981) : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  Text(
                    item.title,
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // Row 2: Date
              Text(
                item.date,
                textAlign: TextAlign.right,
                style: GoogleFonts.notoKufiArabic(
                  fontSize: 10.5,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              const SizedBox(height: 12),
              // Row 3: Stats (Integrity score & count)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${item.integrityScore}%',
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: item.integrityScore >= 90 ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'معدل النزاهة:',
                        style: GoogleFonts.notoKufiArabic(fontSize: 10.5, color: const Color(0xFF64748B)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${item.studentsCount} طالب',
                        style: GoogleFonts.notoKufiArabic(fontSize: 11, fontWeight: FontWeight.bold, color: textDark),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.people_alt_outlined, size: 16, color: Color(0xFF64748B)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HistoryItem {
  final String title;
  final String date;
  final String status;
  final int studentsCount;
  final int integrityScore;
  final bool isActive;

  _HistoryItem({
    required this.title,
    required this.date,
    required this.status,
    required this.studentsCount,
    required this.integrityScore,
    required this.isActive,
  });
}

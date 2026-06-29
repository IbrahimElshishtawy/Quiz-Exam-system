import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressBarChart extends StatelessWidget {
  final double startingRatio; // e.g. 0.15
  final double midwayRatio;   // e.g. 0.55
  final double finishedRatio;  // e.g. 0.30

  final int startingCount;
  final int midwayCount;
  final int finishedCount;

  const ProgressBarChart({
    super.key,
    required this.startingRatio,
    required this.midwayRatio,
    required this.finishedRatio,
    required this.startingCount,
    required this.midwayCount,
    required this.finishedCount,
  });

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);
    final secondaryColor = primaryColor.withOpacity(0.35);

    Widget buildBarColumn(String label, int count, double ratio) {
      return Expanded(
        child: Column(
          children: [
            // Bar column
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: ratio.clamp(0.05, 1.0),
                  child: Container(
                    width: 32,
                    decoration: BoxDecoration(
                      color: ratio >= 0.5 ? primaryColor : secondaryColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Count text
            Text(
              '$count',
              style: GoogleFonts.ibmPlexSans(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 4),
            // Label text
            Text(
              label,
              style: GoogleFonts.notoKufiArabic(
                fontSize: 10,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildBarColumn('منتهي', finishedCount, finishedRatio),
          buildBarColumn('منتصف', midwayCount, midwayRatio),
          buildBarColumn('قيد البدء', startingCount, startingRatio),
        ],
      ),
    );
  }
}

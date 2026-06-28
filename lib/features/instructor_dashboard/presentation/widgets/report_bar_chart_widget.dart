import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportBarChartWidget extends StatelessWidget {
  final List<double> values;

  const ReportBarChartWidget({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    
    // Labels corresponding to grades, from right to left (RTL)
    final List<String> labels = ['ممتاز', 'جيد جداً', 'جيد', 'مقبول', 'ضعيف'];
    // Reorder values to match RTL labels (Excelent at right, Weak at left)
    // values array: [weak, pass, good, very_good, excellent] -> reverse to match labels [excellent, very_good, good, pass, weak]
    final List<double> rtlValues = values.reversed.toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.bar_chart_rounded, color: Color(0xFF005BBF), size: 22),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'توزيع الدرجات',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'توزيع أداء الطلاب في الاختبار الأخير',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 10.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Custom Paint Canvas for the Bar Chart
          SizedBox(
            height: 150,
            child: CustomPaint(
              painter: _BarChartPainter(rtlValues),
            ),
          ),
          const SizedBox(height: 12),

          // Labels Row (RTL)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: labels
                .map((lbl) => Expanded(
                      child: Center(
                        child: Text(
                          lbl,
                          style: GoogleFonts.notoKufiArabic(
                            color: const Color(0xFF64748B),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<double> data;

  _BarChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final int barCount = data.length;
    final double spacing = width * 0.08;
    final double totalSpacing = spacing * (barCount - 1);
    final double barWidth = (width - totalSpacing) / barCount;

    // Find max value to normalize heights
    double maxValue = 1.0;
    for (var v in data) {
      if (v > maxValue) maxValue = v;
    }

    final Paint barPaint = Paint()
      ..style = PaintingStyle.fill;

    for (int i = 0; i < barCount; i++) {
      // Calculate X coordinate
      final double x = i * (barWidth + spacing);
      // Normalize height
      final double normalizedHeight = (data[i] / maxValue) * height * 0.85; // 85% max height
      final double y = height - normalizedHeight;

      // Draw background/outline bars
      final RRect backgroundRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, 0, barWidth, height),
        const Radius.circular(8),
      );
      canvas.drawRRect(
        backgroundRect,
        Paint()..color = const Color(0xFFF8FAFC),
      );

      // Create Gradient color for the active bar
      // Green gradient for Excellent/Very Good (index 0, 1), Blue/Slate for others
      final Color topColor = i < 2 ? const Color(0xFF10B981) : const Color(0xFF005BBF);
      final Color bottomColor = i < 2 ? const Color(0xFF34D399) : const Color(0xFF60A5FA);

      barPaint.shader = LinearGradient(
        colors: [topColor, bottomColor],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(x, y, barWidth, normalizedHeight));

      final RRect activeRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, normalizedHeight),
        const Radius.circular(8),
      );

      canvas.drawRRect(activeRect, barPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportLineChartWidget extends StatelessWidget {
  final List<double> values;

  const ReportLineChartWidget({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);

    // Month labels corresponding to coordinates, from right to left (RTL)
    final List<String> labels = ['ديسمبر', 'نوفمبر', 'أكتوبر', 'سبتمبر'];
    // Reorder values to match RTL months (December at right, September at left)
    // values array: [Sept, Oct, Nov, Dec] -> reverse to match labels [Dec, Nov, Oct, Sept]
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
              const Icon(Icons.trending_up_rounded, color: Color(0xFF10B981), size: 22),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'متوسط الأداء',
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'المنحنى الزمني للفصل الحالي',
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

          // Custom Paint Canvas for the Line Chart
          SizedBox(
            height: 150,
            child: CustomPaint(
              painter: _LineChartPainter(rtlValues),
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

class _LineChartPainter extends CustomPainter {
  final List<double> data;

  _LineChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final int pointCount = data.length;
    final double spacing = width / (pointCount - 1);

    // Find min and max values to normalize heights
    double maxValue = 100.0;
    double minValue = 0.0;

    // Map data to canvas coordinates
    final List<Offset> points = [];
    for (int i = 0; i < pointCount; i++) {
      final double x = i * spacing;
      // Normalize y (100% maps to height*0.1, 0% maps to height*0.9)
      final double normalizedValue = (data[i] - minValue) / (maxValue - minValue);
      final double y = height - (normalizedValue * height * 0.7 + height * 0.1);
      points.add(Offset(x, y));
    }

    // Draw grid helper lines
    final Paint gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(0, height * 0.1), Offset(width, height * 0.1), gridPaint);
    canvas.drawLine(Offset(0, height * 0.5), Offset(width, height * 0.5), gridPaint);
    canvas.drawLine(Offset(0, height * 0.9), Offset(width, height * 0.9), gridPaint);

    // Draw spline curve
    final Path path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < pointCount - 1; i++) {
      final Offset p0 = points[i];
      final Offset p1 = points[i + 1];
      
      // Control points for smooth bezier cubic curve
      final double controlX1 = p0.dx + (p1.dx - p0.dx) / 2;
      final double controlY1 = p0.dy;
      final double controlX2 = p0.dx + (p1.dx - p0.dx) / 2;
      final double controlY2 = p1.dy;

      path.cubicTo(controlX1, controlY1, controlX2, controlY2, p1.dx, p1.dy);
    }

    final Paint linePaint = Paint()
      ..color = const Color(0xFF005BBF) // Blue line curve
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    // Draw fading shadow fill under the curve
    final Path fillPath = Path.from(path);
    fillPath.lineTo(width, height);
    fillPath.lineTo(0, height);
    fillPath.close();

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF005BBF).withOpacity(0.15),
          const Color(0xFF005BBF).withOpacity(0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, width, height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    // Draw data points/dots
    final Paint dotPaint = Paint()
      ..color = const Color(0xFF005BBF)
      ..style = PaintingStyle.fill;

    final Paint outerDotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (var pt in points) {
      canvas.drawCircle(pt, 6, dotPaint);
      canvas.drawCircle(pt, 3, outerDotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

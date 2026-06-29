import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircularIntegrityChart extends StatelessWidget {
  final double percentage; // e.g. 0.92
  final double size;

  const CircularIntegrityChart({
    super.key,
    required this.percentage,
    this.size = 140.0,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF10B981); // Green index
    const inactiveColor = Color(0xFFE2E8F0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular rings
          CustomPaint(
            size: Size(size, size),
            painter: _CircularGaugePainter(
              percentage: percentage,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              strokeWidth: 12,
            ),
          ),
          
          // Inside Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(percentage * 100).toInt()}%',
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircularGaugePainter extends CustomPainter {
  final double percentage;
  final Color activeColor;
  final Color inactiveColor;
  final double strokeWidth;

  _CircularGaugePainter({
    required this.percentage,
    required this.activeColor,
    required this.inactiveColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw background track
    final bgPaint = Paint()
      ..color = inactiveColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      2 * pi,  // Full circle
      false,
      bgPaint,
    );

    // Draw active track
    final activePaint = Paint()
      ..color = activeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      2 * pi * percentage,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularGaugePainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

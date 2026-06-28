import 'dart:math' as math;
import 'package:flutter/material.dart';

class SetupIllustration extends StatefulWidget {
  const SetupIllustration({super.key});

  @override
  State<SetupIllustration> createState() => _SetupIllustrationState();
}

class _SetupIllustrationState extends State<SetupIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _floatingAnimation;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _floatingAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );

    _glowAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryGlow = Color(0xFF6366F1); // Indigo glow

    return SizedBox(
      width: double.infinity,
      height: 180,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Background Floating Bubbles
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: BubblesPainter(animationValue: _controller.value),
                );
              },
            ),
          ),

          // Open Book Drawing
          Positioned(
            bottom: 10,
            child: CustomPaint(
              size: const Size(190, 60),
              painter: OpenBookPainter(),
            ),
          ),

          // Glowing Light Bulb (Floating)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                bottom: 50 + _floatingAnimation.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer glow aura
                    Opacity(
                      opacity: 0.25,
                      child: Transform.scale(
                        scale: _glowAnimation.value,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                    // Core bulb ring glow
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.4),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.lightbulb_rounded,
                        color: Colors.amber,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OpenBookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bookPaint = Paint()
      ..color = const Color(0xFFE2E8F0) // Cool grey
      ..style = PaintingStyle.fill;

    final spinePaint = Paint()
      ..color = const Color(0xFF94A3B8) // Slate grey spine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final path = Path();
    
    // Left Page
    path.moveTo(size.width / 2, size.height - 5);
    path.quadraticBezierTo(size.width * 0.25, size.height - 35, 10, size.height - 15);
    path.lineTo(15, 10);
    path.quadraticBezierTo(size.width * 0.25, 20, size.width / 2, 5);
    
    // Right Page
    path.quadraticBezierTo(size.width * 0.75, 20, size.width - 15, 10);
    path.lineTo(size.width - 10, size.height - 15);
    path.quadraticBezierTo(size.width * 0.75, size.height - 35, size.width / 2, size.height - 5);
    
    canvas.drawPath(path, bookPaint);
    
    // Draw page lines/spine
    canvas.drawLine(Offset(size.width / 2, 5), Offset(size.width / 2, size.height - 5), spinePaint);

    // Decorative page lines
    final linePaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Left Page decorative line
    final linePathLeft = Path()
      ..moveTo(size.width * 0.15, size.height - 18)
      ..quadraticBezierTo(size.width * 0.3, size.height - 30, size.width * 0.45, size.height - 15);
    canvas.drawPath(linePathLeft, linePaint);

    // Right Page decorative line
    final linePathRight = Path()
      ..moveTo(size.width * 0.55, size.height - 15)
      ..quadraticBezierTo(size.width * 0.7, size.height - 30, size.width * 0.85, size.height - 18);
    canvas.drawPath(linePathRight, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BubblesPainter extends CustomPainter {
  final double animationValue;

  BubblesPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final bubblePaint = Paint()
      ..color = const Color(0xFF38BDF8).withOpacity(0.12) // Sky blue transparent
      ..style = PaintingStyle.fill;

    // Drawing 3 static bubble loops with animation offset
    double offset1 = math.sin(animationValue * 2 * math.pi) * 8;
    double offset2 = math.cos(animationValue * 2 * math.pi) * 6;

    // Left Bubble
    canvas.drawCircle(Offset(size.width * 0.2 + offset1, size.height * 0.55 + offset2), 16, bubblePaint);

    // Top Right Bubble
    canvas.drawCircle(Offset(size.width * 0.8 - offset2, size.height * 0.4 + offset1), 22, bubblePaint);

    // Mid Right Bubble
    canvas.drawCircle(Offset(size.width * 0.75 + offset1, size.height * 0.7 - offset2), 10, bubblePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

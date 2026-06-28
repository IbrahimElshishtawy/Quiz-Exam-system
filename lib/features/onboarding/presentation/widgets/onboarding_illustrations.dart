import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- BASE FLOATING WIDGET FOR SMOOTH AMBIENT ANIMATIONS ---
class FloatingWidget extends StatefulWidget {
  final Widget child;
  final double durationSeconds;
  final double offsetDistance;
  final bool reverse;

  const FloatingWidget({
    super.key,
    required this.child,
    this.durationSeconds = 3.0,
    this.offsetDistance = 8.0,
    this.reverse = false,
  });

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.durationSeconds * 1000).toInt()),
    );

    _animation = Tween<double>(
      begin: widget.reverse ? widget.offsetDistance : -widget.offsetDistance,
      end: widget.reverse ? -widget.offsetDistance : widget.offsetDistance,
    ).animate(
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ==========================================
// 1. ILLUSTRATION FOR PAGE 0: SECURE EXAM (Tablet + Shield)
// ==========================================
class SecureExamIllustration extends StatefulWidget {
  const SecureExamIllustration({super.key});

  @override
  State<SecureExamIllustration> createState() => _SecureExamIllustrationState();
}

class _SecureExamIllustrationState extends State<SecureExamIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
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
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
        color: const Color(0xFF070B19),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Cyber Grid Background
            Positioned.fill(
              child: CustomPaint(
                painter: GridPainter(color: Colors.blue.withOpacity(0.05)),
              ),
            ),
            // Cyber glowing orbs
            Positioned(
              left: -50,
              top: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.withOpacity(0.15),
                ),
              ),
            ),
            Positioned(
              right: -50,
              bottom: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigo.withOpacity(0.2),
                ),
              ),
            ),
            // Tilted Tablet Base
            FloatingWidget(
              durationSeconds: 3.5,
              offsetDistance: 6,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(0.2)
                  ..rotateY(-0.15)
                  ..rotateZ(0.05),
                alignment: Alignment.center,
                child: Container(
                  width: 210,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF334155),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Simulated Screen Content
                      Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: 30, height: 6, decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(3))),
                            Container(width: 40, height: 6, decoration: BoxDecoration(color: Colors.blue.shade600, borderRadius: BorderRadius.circular(3))),
                          ],
                        ),
                      ),
                      // Inner Glowing Ring
                      ScaleTransition(
                        scale: _pulseAnimation,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      // Security Shield Icon
                      const Icon(
                        Icons.shield_outlined,
                        color: Colors.blue,
                        size: 55,
                      ),
                      const Icon(
                        Icons.lock_rounded,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Floating Security Nodes
            Positioned(
              left: 40,
              top: 70,
              child: FloatingWidget(
                durationSeconds: 2.8,
                offsetDistance: 8,
                reverse: true,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F172A),
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.cyanAccent, blurRadius: 4)],
                  ),
                  child: const Icon(Icons.check_circle, color: Colors.cyanAccent, size: 20),
                ),
              ),
            ),
            Positioned(
              right: 40,
              bottom: 80,
              child: FloatingWidget(
                durationSeconds: 3.2,
                offsetDistance: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F172A),
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.blueAccent, blurRadius: 4)],
                  ),
                  child: const Icon(Icons.fingerprint_rounded, color: Colors.blueAccent, size: 20),
                ),
              ),
            ),
            // Top Left Badge: "ذكاء اصطناعي آمن"
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF005BBF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ذكاء اصطناعي آمن',
                  style: GoogleFonts.notoKufiArabic(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. ILLUSTRATION FOR PAGE 1: AI ANALYTICS (Brain + Overlay Cards)
// ==========================================
class AIAnalyticsIllustration extends StatelessWidget {
  const AIAnalyticsIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Cyber Grid
            Positioned.fill(
              child: CustomPaint(
                painter: GridPainter(color: Colors.indigo.withOpacity(0.04)),
              ),
            ),
            // Glowing Brain Center
            FloatingWidget(
              durationSeconds: 4.0,
              offsetDistance: 6,
              child: Center(
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF6366F1).withOpacity(0.35),
                        const Color(0xFF6366F1).withOpacity(0.0),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    color: Color(0xFF818CF8),
                    size: 90,
                  ),
                ),
              ),
            ),
            // Pie chart background circles
            Positioned(
              top: 50,
              right: 80,
              child: Opacity(
                opacity: 0.15,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 6),
                  ),
                ),
              ),
            ),
            // Floating Overlay Card 1: Top-Left Line Chart
            Positioned(
              left: 20,
              top: 30,
              child: FloatingWidget(
                durationSeconds: 3.2,
                offsetDistance: 8,
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B).withOpacity(0.85),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF334155), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            height: 8,
                            decoration: BoxDecoration(color: Colors.grey.shade500, borderRadius: BorderRadius.circular(4)),
                          ),
                          const Icon(Icons.trending_up, color: Colors.blueAccent, size: 16),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 70,
                        height: 8,
                        decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(height: 12),
                      // Custom Mini Line Graph representation
                      SizedBox(
                        height: 24,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: MiniLinePainter(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Floating Overlay Card 2: Bottom-Right Progress / Success Card
            Positioned(
              right: 20,
              bottom: 40,
              child: FloatingWidget(
                durationSeconds: 2.8,
                offsetDistance: 6,
                reverse: true,
                child: Container(
                  width: 140,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B).withOpacity(0.85),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF334155), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 14),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 8,
                              decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(4)),
                            ),
                            const SizedBox(height: 6),
                            // Simulated Progress Bar
                            Container(
                              width: double.infinity,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.7,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. ILLUSTRATION FOR PAGE 2: ANYTIME ANYWHERE (Woman + Plants + Badges)
// ==========================================
class AnywhereAnytimeIllustration extends StatelessWidget {
  const AnywhereAnytimeIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFE0F2FE).withOpacity(0.4),
            const Color(0xFFF0FDFA).withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.blue.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Abstract lounge room components
            // Large circular window gradient
            Positioned(
              left: 40,
              top: 30,
              child: Container(
                width: 140,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(70)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
                  ],
                ),
              ),
            ),
            // Potted plant shape (Abstract vector style)
            Positioned(
              left: 16,
              bottom: 20,
              child: FloatingWidget(
                durationSeconds: 4.5,
                offsetDistance: 3,
                child: Column(
                  children: [
                    // Leaf 1
                    Transform.rotate(
                      angle: -0.2,
                      child: Container(
                        width: 16,
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.5),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Pot
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD1D5DB),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sitting Figure representation holding a Tablet
            // Built using simple geometric circles/ovals for premium abstract art
            Positioned(
              right: 35,
              bottom: 40,
              child: FloatingWidget(
                durationSeconds: 3.8,
                offsetDistance: 4,
                child: SizedBox(
                  width: 170,
                  height: 180,
                  child: Stack(
                    children: [
                      // Lounge Chair Silhouette
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: CustomPaint(
                          size: const Size(170, 90),
                          painter: LoungeChairPainter(),
                        ),
                      ),
                      // Figure Head
                      Positioned(
                        top: 25,
                        right: 35,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF9A8D4), // Soft peach skin
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Figure Body & Arms (Holding tablet)
                      Positioned(
                        top: 50,
                        right: 20,
                        child: Transform.rotate(
                          angle: -0.3,
                          child: Container(
                            width: 60,
                            height: 35,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F766E).withOpacity(0.8), // Teal clothing
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      // Tablet Glow Screen
                      Positioned(
                        top: 45,
                        left: 20,
                        child: Transform.rotate(
                          angle: 0.1,
                          child: Container(
                            width: 42,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.4),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: const Center(
                              child: Icon(Icons.bar_chart, color: Colors.blueAccent, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Floating Badge 1: Top-Right Green Checkmark
            Positioned(
              right: 30,
              top: 30,
              child: FloatingWidget(
                durationSeconds: 3.0,
                offsetDistance: 7,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 18),
                  ),
                ),
              ),
            ),
            // Floating Badge 2: Bottom-Left Blue Bar Chart
            Positioned(
              left: 30,
              bottom: 110,
              child: FloatingWidget(
                durationSeconds: 3.5,
                offsetDistance: 9,
                reverse: true,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: const Icon(Icons.bar_chart_rounded, color: Color(0xFF005BBF), size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- CUSTOM PAINTERS FOR VECTOR GRAPHICS ---

class GridPainter extends CustomPainter {
  final Color color;
  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    const spacing = 20.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MiniLinePainter extends CustomPainter {
  final Color color;
  MiniLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.2, size.width * 0.5, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.8, size.width, size.height * 0.1);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LoungeChairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF334155).withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    // Chair path (base & support structure)
    final path = Path()
      ..moveTo(10, size.height - 10)
      ..cubicTo(size.width * 0.2, size.height - 10, size.width * 0.4, size.height - 35, size.width * 0.6, size.height - 45)
      ..cubicTo(size.width * 0.8, size.height - 55, size.width * 0.9, size.height - 70, size.width - 10, 10);

    canvas.drawPath(path, paint);

    // Chair Leg
    final legPaint = Paint()
      ..color = const Color(0xFF64748B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawLine(Offset(size.width * 0.4, size.height - 35), Offset(size.width * 0.4, size.height), legPaint);
    canvas.drawLine(Offset(size.width * 0.6, size.height - 45), Offset(size.width * 0.7, size.height), legPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

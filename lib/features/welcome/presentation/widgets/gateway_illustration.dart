import 'dart:math' as math;
import 'package:flutter/material.dart';

class GatewayIllustration extends StatefulWidget {
  const GatewayIllustration({super.key});

  @override
  State<GatewayIllustration> createState() => _GatewayIllustrationState();
}

class _GatewayIllustrationState extends State<GatewayIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<ParticleModel> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Create 15 random background particles
    final random = math.Random();
    _particles = List.generate(15, (index) {
      return ParticleModel(
        x: random.nextDouble() * 260,
        y: random.nextDouble() * 150,
        size: random.nextDouble() * 5 + 2,
        speed: random.nextDouble() * 0.4 + 0.2,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);

    return SizedBox(
      width: 280,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient Particle Drift
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(280, 200),
                painter: ParticlePainter(
                  particles: _particles,
                  progress: _controller.value,
                ),
              );
            },
          ),
          
          // Main Glowing Logo Container
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: primaryColor.withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Inner thin glow border
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                // Graduation Cap Icon
                const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ParticleModel {
  double x;
  double y;
  final double size;
  final double speed;

  ParticleModel({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
  });
}

class ParticlePainter extends CustomPainter {
  final List<ParticleModel> particles;
  final double progress;

  ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF005BBF).withOpacity(0.15);

    for (var particle in particles) {
      // Drift upwards
      double currentY = particle.y - (progress * 150 * particle.speed);
      if (currentY < 0) {
        currentY += size.height;
      }
      
      // Horizontal wave movement
      double currentX = particle.x + math.sin(progress * 2 * math.pi + particle.y) * 10;
      if (currentX < 0) currentX += size.width;
      if (currentX > size.width) currentX -= size.width;

      canvas.drawCircle(Offset(currentX, currentY), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

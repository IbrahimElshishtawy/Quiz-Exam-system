// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Logo Animation (Rotates and scales up/down at entry)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 60,
      ),
    ]).animate(_logoController);

    // Starts at 3 degrees (0.052 radians) and goes to 0
    _rotationAnimation = Tween<double>(
      begin: 3 * 3.14159 / 180,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    // Delay start of logo animation slightly to match HTML's setTimeout
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _logoController.forward();
      }
    });

    // 2. Redirect Simulation after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      _handleNavigation();
    });
  }

  void _handleNavigation() {
    final box = GetStorage();
    final bool hasCompletedOnboarding = box.read<bool>('has_completed_onboarding') ?? false;

    if (!hasCompletedOnboarding) {
      Get.offAllNamed(Routes.ONBOARDING);
      return;
    }

    final String? role = box.read('user_role');

    if (role == null) {
      Get.offAllNamed(Routes.WELCOME_GATEWAY);
    } else if (role == 'student') {
      Get.offAllNamed(Routes.EXAM_DETAILS);
    } else if (role == 'instructor') {
      Get.offAllNamed(Routes.INSTRUCTOR_DASHBOARD);
    } else if (role == 'developer') {
      Get.offAllNamed(Routes.DEVELOPER_DASHBOARD);
    } else {
      Get.offAllNamed(Routes.WELCOME_GATEWAY);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Custom colors from the HTML specifications
    const primaryColor = Color(0xFF005BBF);
    const onSurfaceColor = Color(0xFF171C20);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Subtle Glow Orb (Radial Gradient at the bottom)
          Positioned(
            bottom: -150,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 600,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      primaryColor.withOpacity(0.08),
                      primaryColor.withOpacity(0.0),
                    ],
                    radius: 0.7,
                  ),
                ),
              ),
            ),
          ),

          // 2. Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Minimalist Logo Container with entry animations
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Inner thin border simulation
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 4,
                              ),
                            ),
                          ),
                        ),
                        // Graduation AI cap/school icon
                        const Center(
                          child: Icon(
                            Icons.school_rounded,
                            color: Colors.white,
                            size: 70,
                          ),
                        ),
                        // Neurology node hybrid overlay
                        Positioned(
                          bottom: -8,
                          right: -8,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.psychology_rounded,
                              color: primaryColor,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Platform Name - Arabic Typography
                Text(
                  'إيدو أسيس الذكي',
                  style: GoogleFonts.notoKufiArabic(
                    color: primaryColor,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.25,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'EduAssess AI',
                  style: GoogleFonts.notoKufiArabic(
                    color: onSurfaceColor.withOpacity(0.6),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 100),

                // AI Pulse Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AnimatedPulseDot(delay: Duration(milliseconds: 0)),
                    const SizedBox(width: 8),
                    const AnimatedPulseDot(delay: Duration(milliseconds: 400)),
                    const SizedBox(width: 8),
                    const AnimatedPulseDot(delay: Duration(milliseconds: 800)),
                    const SizedBox(width: 16),
                    Text(
                      'جاري التحميل الذكي...',
                      style: GoogleFonts.notoKufiArabic(
                        color: primaryColor.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 3. Footer Branding
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Text(
              'POWERED BY ADVANCED NEURAL NETWORKS',
              textAlign: TextAlign.center,
              style: GoogleFonts.ibmPlexSans(
                color: onSurfaceColor.withOpacity(0.4),
                fontSize: 11,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom widget for individual staggered pulse dots
class AnimatedPulseDot extends StatefulWidget {
  final Duration delay;
  const AnimatedPulseDot({super.key, required this.delay});

  @override
  State<AnimatedPulseDot> createState() => _AnimatedPulseDotState();
}

class _AnimatedPulseDotState extends State<AnimatedPulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _dotController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.8)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.8, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_dotController);

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.2, end: 0.6)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.6, end: 0.2)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_dotController);

    // Stagger start using the delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        _dotController.repeat();
      }
    });
  }

  @override
  void dispose() {
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);

    return AnimatedBuilder(
      animation: _dotController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}

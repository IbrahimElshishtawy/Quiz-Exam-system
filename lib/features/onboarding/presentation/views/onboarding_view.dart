import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_page_widget.dart';
import '../widgets/custom_dot_indicator.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005BBF);
    const textDarkColor = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Obx(() {
          final int currentIndex = controller.currentIndex.value;
          final bool isFirstPage = currentIndex == 0;
          final bool isLastPage = controller.isLastPage;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left action: Skip button (only shown if not on the last page)
                  if (!isLastPage)
                    TextButton(
                      onPressed: () => controller.skipOnboarding(),
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: Text(
                        currentIndex == 1 ? 'Skip' : 'تخطي',
                        style: GoogleFonts.notoKufiArabic(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 60),

                  // Center: Title Branding
                  Text(
                    'EduAssess AI',
                    style: GoogleFonts.ibmPlexSans(
                      color: primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),

                  // Right action: Back button (shown if not on the first page)
                  if (!isFirstPage)
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_rounded, color: primaryColor),
                      tooltip: 'السابق',
                      onPressed: () {
                        controller.pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                    )
                  else
                    // Simple placeholder for alignment
                    const SizedBox(width: 48),
                ],
              ),
            ),
          );
        }),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Page Slider
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(page: controller.pages[index]);
                },
              ),
            ),

            // Bottom Navigation and Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Obx(() {
                final int currentIndex = controller.currentIndex.value;
                final bool isLastPage = controller.isLastPage;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dot Indicators
                    CustomDotIndicator(
                      pageCount: controller.pages.length,
                      currentIndex: currentIndex,
                      activeColor: primaryColor,
                    ),
                    const SizedBox(height: 32),

                    // Next/Get Started Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => controller.nextPage(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          shadowColor: primaryColor.withOpacity(0.4),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: isLastPage
                              ? Row(
                                  key: const ValueKey('start_btn'),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 22),
                                    const SizedBox(width: 8),
                                    Text(
                                      'ابدأ الآن',
                                      style: GoogleFonts.notoKufiArabic(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  key: const ValueKey('next_btn'),
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      currentIndex == 1 ? Icons.arrow_back : Icons.arrow_back_ios_new_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'التالي',
                                      style: GoogleFonts.notoKufiArabic(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),

                    // Additional bottom options (e.g. skip tour on Page 1)
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: currentIndex == 1
                          ? Padding(
                              padding: const EdgeInsets.top(16.0),
                              child: TextButton(
                                onPressed: () => controller.skipOnboarding(),
                                style: TextButton.styleFrom(
                                  foregroundColor: primaryColor,
                                ),
                                child: Text(
                                  'تخطي الجولة التعليمية',
                                  style: GoogleFonts.notoKufiArabic(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

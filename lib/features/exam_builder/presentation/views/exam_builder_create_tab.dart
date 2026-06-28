import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/exam_builder_controller.dart';
import '../widgets/step_indicator.dart';
import 'steps/exam_builder_details_step.dart';
import 'steps/exam_builder_settings_step.dart';
import 'steps/exam_builder_review_step.dart';

class ExamBuilderCreateTab extends GetView<ExamBuilderController> {
  const ExamBuilderCreateTab({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF1E293B);
    const primaryColor = Color(0xFF005BBF);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: primaryColor),
          onPressed: () {
            if (controller.wizardStep.value > 0) {
              controller.prevStep();
            } else {
              controller.currentTabIndex.value = 0; // Back to Home
            }
          },
        ),
        centerTitle: true,
        title: Text(
          'بناء اختبار جديد',
          style: GoogleFonts.notoKufiArabic(
            color: textDark,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Stepper Indicator row
            Obx(() => StepIndicator(activeIndex: controller.wizardStep.value)),

            // Form Content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Obx(() {
                  final int step = controller.wizardStep.value;

                  // Optimized slide-fade AnimatedSwitcher for lag-free stepper shifts
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.04, 0.0), // subtle RTL slide
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      key: ValueKey<int>(step),
                      child: _getStepWidget(step),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getStepWidget(int step) {
    switch (step) {
      case 0:
        return const ExamBuilderDetailsStep();
      case 1:
        return const ExamBuilderSettingsStep();
      case 2:
        return const ExamBuilderReviewStep();
      default:
        return const ExamBuilderDetailsStep();
    }
  }
}

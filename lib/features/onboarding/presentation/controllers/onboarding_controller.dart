import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/entities/onboarding_page_entity.dart';
import '../../domain/usecases/complete_onboarding.dart';

class OnboardingController extends GetxController {
  final CompleteOnboarding completeOnboardingUseCase;

  OnboardingController({required this.completeOnboardingUseCase});

  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  final List<OnboardingPageEntity> pages = const [
    OnboardingPageEntity(
      index: 0,
      title: 'اختبارات آمنة وموثوقة',
      subtitle: 'نستخدم أحدث تقنيات الذكاء الاصطناعي لضمان نزاهة وجودة كل اختبار، مما يوفر تجربة تقييم عادلة وشفافة للجميع.',
      badgeText: 'ذكاء اصطناعي آمن',
    ),
    OnboardingPageEntity(
      index: 1,
      title: 'تحليلات دقيقة بالذكاء الاصطناعي',
      subtitle: 'احصل على تقارير مفصلة وتحليلات ذكية لأدائك لتحسين نتائجك التعليمية.',
    ),
    OnboardingPageEntity(
      index: 2,
      title: 'في أي وقت وفي أي مكان',
      subtitle: 'سهولة الوصول إلى اختباراتك ونتائجك من أي جهاز وفي أي وقت تفضله.',
    ),
  ];

  bool get isLastPage => currentIndex.value == pages.length - 1;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  Future<void> nextPage() async {
    if (isLastPage) {
      await finishOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> skipOnboarding() async {
    await finishOnboarding();
  }

  Future<void> finishOnboarding() async {
    await completeOnboardingUseCase();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/developer/presentation/views/developer_dashboard_view.dart';
import 'package:flutter_application_1/features/exam/presentation/Binding/Exam_Binding.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/presentation/views/register_view.dart';
import '../features/auth/presentation/views/splash_view.dart';
import '../features/auth/bindings/auth_binding.dart';
import '../features/onboarding/presentation/views/onboarding_view.dart';
import '../features/onboarding/bindings/onboarding_binding.dart';
import '../features/welcome/presentation/views/welcome_gateway_view.dart';
import '../features/welcome/presentation/views/welcome_setup_view.dart';
import '../features/welcome/bindings/welcome_binding.dart';
import '../features/exam/presentation/views/exam_player_view.dart';
import '../features/exam/presentation/views/exam_details_view.dart';
import '../features/exam/presentation/views/exam_result_view.dart';
import '../features/exam/presentation/views/exam_builder_view.dart';
import '../features/room/presentation/views/room_dashboard_view.dart';
import '../features/reports/presentation/views/exam_reports_view.dart';
import '../features/reports/presentation/views/exam_analytics_view.dart';
import '../features/student_dashboard/presentation/views/student_dashboard_layout.dart';
import '../features/student_dashboard/presentation/views/upcoming_exams_view.dart';
import '../features/student_dashboard/bindings/student_dashboard_binding.dart';
import '../features/instructor_dashboard/presentation/views/instructor_dashboard_layout.dart';
import '../features/instructor_dashboard/bindings/instructor_dashboard_binding.dart';
import '../core/middleware/auth_middleware.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.WELCOME_GATEWAY,
      page: () => const WelcomeGatewayView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: Routes.WELCOME_SETUP,
      page: () => const WelcomeSetupView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),

    // Student Pages
    GetPage(
      name: Routes.STUDENT_DASHBOARD,
      page: () => const StudentDashboardLayout(),
      binding: StudentDashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.UPCOMING_EXAMS,
      page: () => const UpcomingExamsView(),
      binding: StudentDashboardBinding(),
    ),
    GetPage(
      name: Routes.EXAM_DETAILS,
      page: () => const ExamDetailsView(),
      binding: ExamBinding(),
    ),

    GetPage(
      name: Routes.EXAM_PLAYER,
      page: () => const ExamPlayerView(),
      binding: ExamBinding(), // ✅ ده اللي هيحل المشكلة
    ),

    GetPage(
      name: Routes.EXAM_RESULT,
      page: () => const ExamResultView(),
      binding: ExamBinding(),
    ),
    // Instructor Pages
    GetPage(
      name: Routes.INSTRUCTOR_DASHBOARD,
      page: () => const InstructorDashboardLayout(),
      binding: InstructorDashboardBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: Routes.EXAM_BUILDER, page: () => const ExamBuilderView()),
    GetPage(name: Routes.EXAM_MONITOR, page: () => const ExamMonitorView()),
    GetPage(name: Routes.EXAM_REPORTS, page: () => const ExamAnalyticsView()),
    GetPage(
      name: Routes.DEVELOPER_DASHBOARD,
      page: () => const DeveloperDashboardView(),
    ),
  ];
}

class PlaceholderView extends StatelessWidget {
  final String title;
  const PlaceholderView({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}

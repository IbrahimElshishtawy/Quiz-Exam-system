// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/bindings/auth_binding.dart';
import '../features/exam/presentation/views/exam_player_view.dart';
import '../features/exam/presentation/views/exam_details_view.dart';
import '../features/exam/presentation/views/exam_result_view.dart';
import '../features/exam/presentation/views/exam_builder_view.dart';
import '../features/room/presentation/views/room_dashboard_view.dart';
import '../features/reports/presentation/views/exam_reports_view.dart';
import '../features/reports/presentation/views/exam_analytics_view.dart';
import '../core/middleware/auth_middleware.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),

    // Student Pages
    GetPage(
      name: Routes.STUDENT_DASHBOARD,
      page: () => const PlaceholderView(title: 'Student Dashboard'),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: Routes.EXAM_DETAILS, page: () => const ExamDetailsView()),
    GetPage(name: Routes.EXAM_PLAYER, page: () => const ExamPlayerView()),
    GetPage(name: Routes.EXAM_RESULT, page: () => const ExamResultView()),

    // Instructor Pages
    GetPage(
      name: Routes.INSTRUCTOR_DASHBOARD,
      page: () => const RoomDashboardView(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: Routes.EXAM_BUILDER, page: () => const ExamBuilderView()),
    GetPage(name: Routes.EXAM_MONITOR, page: () => const ExamMonitorView()),
    GetPage(name: Routes.EXAM_REPORTS, page: () => const ExamAnalyticsView()),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../routes/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    final String? role = box.read('user_role');

    if (role == null) {
      return const RouteSettings(name: Routes.LOGIN);
    }

    // Simple role check for the demo
    if (route != null) {
      if (route.contains('student') && role != 'student') {
        return const RouteSettings(name: Routes.INSTRUCTOR_DASHBOARD);
      }
      if (route.contains('instructor') && role != 'instructor') {
        return const RouteSettings(name: Routes.STUDENT_DASHBOARD);
      }
    }

    return null;
  }
}

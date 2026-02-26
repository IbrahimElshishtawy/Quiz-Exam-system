import 'package:get/get.dart';
import 'app_routes.dart';
import '../features/auth/presentation/views/login_view.dart';
import '../features/auth/bindings/auth_binding.dart';
import '../features/room/presentation/views/join_room_view.dart';
import '../features/exam/presentation/views/exam_view.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.ROOM_JOIN,
      page: () => const JoinRoomView(),
    ),
    GetPage(
      name: Routes.EXAM,
      page: () => const ExamView(),
    ),
  ];
}

import 'package:get/get.dart';
import '../data/datasources/student_dashboard_local_datasource.dart';
import '../data/repositories/student_dashboard_repository_impl.dart';
import '../domain/repositories/student_dashboard_repository.dart';
import '../domain/usecases/get_notifications.dart';
import '../domain/usecases/get_student_achievements.dart';
import '../domain/usecases/get_student_schedule.dart';
import '../presentation/controllers/student_dashboard_controller.dart';

class StudentDashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Local Data Source
    Get.lazyPut<StudentDashboardLocalDataSource>(
      () => StudentDashboardLocalDataSourceImpl(),
    );

    // Repository
    Get.lazyPut<StudentDashboardRepository>(
      () => StudentDashboardRepositoryImpl(
        localDataSource: Get.find<StudentDashboardLocalDataSource>(),
      ),
    );

    // Use cases
    Get.lazyPut<GetStudentSchedule>(
      () => GetStudentSchedule(Get.find<StudentDashboardRepository>()),
    );
    Get.lazyPut<GetNotifications>(
      () => GetNotifications(Get.find<StudentDashboardRepository>()),
    );
    Get.lazyPut<GetStudentAchievements>(
      () => GetStudentAchievements(Get.find<StudentDashboardRepository>()),
    );

    // Controller
    Get.put<StudentDashboardController>(
      StudentDashboardController(
        getStudentScheduleUseCase: Get.find<GetStudentSchedule>(),
        getNotificationsUseCase: Get.find<GetNotifications>(),
        getStudentAchievementsUseCase: Get.find<GetStudentAchievements>(),
      ),
    );
  }
}

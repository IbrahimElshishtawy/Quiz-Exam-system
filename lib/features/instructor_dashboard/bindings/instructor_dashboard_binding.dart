import 'package:get/get.dart';
import '../data/datasources/instructor_dashboard_local_datasource.dart';
import '../data/repositories/instructor_dashboard_repository_impl.dart';
import '../domain/repositories/instructor_dashboard_repository.dart';
import '../domain/usecases/get_instructor_exams.dart';
import '../domain/usecases/get_instructor_report_data.dart';
import '../domain/usecases/get_instructor_stats.dart';
import '../domain/usecases/get_proctoring_alerts.dart';
import '../presentation/controllers/instructor_dashboard_controller.dart';

class InstructorDashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Local Data Source
    Get.lazyPut<InstructorDashboardLocalDataSource>(
      () => InstructorDashboardLocalDataSourceImpl(),
    );

    // Repository implementation
    Get.lazyPut<InstructorDashboardRepository>(
      () => InstructorDashboardRepositoryImpl(
        localDataSource: Get.find<InstructorDashboardLocalDataSource>(),
      ),
    );

    // Use cases
    Get.lazyPut<GetInstructorExams>(
      () => GetInstructorExams(Get.find<InstructorDashboardRepository>()),
    );
    Get.lazyPut<GetProctoringAlerts>(
      () => GetProctoringAlerts(Get.find<InstructorDashboardRepository>()),
    );
    Get.lazyPut<GetInstructorStats>(
      () => GetInstructorStats(Get.find<InstructorDashboardRepository>()),
    );
    Get.lazyPut<GetInstructorReportData>(
      () => GetInstructorReportData(Get.find<InstructorDashboardRepository>()),
    );

    // Controller
    Get.put<InstructorDashboardController>(
      InstructorDashboardController(
        getInstructorExamsUseCase: Get.find<GetInstructorExams>(),
        getProctoringAlertsUseCase: Get.find<GetProctoringAlerts>(),
        getInstructorStatsUseCase: Get.find<GetInstructorStats>(),
        getInstructorReportDataUseCase: Get.find<GetInstructorReportData>(),
      ),
    );
  }
}

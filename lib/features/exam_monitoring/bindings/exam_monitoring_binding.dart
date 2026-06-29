import 'package:get/get.dart';
import '../data/datasources/mock_monitoring_datasource.dart';
import '../data/repositories/monitoring_repository_impl.dart';
import '../domain/repositories/monitoring_repository.dart';
import '../presentation/controllers/exam_monitoring_controller.dart';

class ExamMonitoringBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Data Sources
    Get.lazyPut<MockMonitoringDatasource>(() => MockMonitoringDatasource());

    // 2. Repositories
    Get.lazyPut<MonitoringRepository>(
      () => MonitoringRepositoryImpl(Get.find<MockMonitoringDatasource>()),
    );

    // 3. Controllers
    Get.lazyPut<ExamMonitoringController>(
      () => ExamMonitoringController(Get.find<MonitoringRepository>()),
    );
  }
}

import 'package:get/get.dart';
import '../data/datasources/exam_builder_local_datasource.dart';
import '../data/repositories/exam_builder_repository_impl.dart';
import '../domain/repositories/exam_builder_repository.dart';
import '../domain/usecases/get_exams.dart';
import '../domain/usecases/get_builder_activities.dart';
import '../domain/usecases/save_exam.dart';
import '../domain/usecases/delete_exam.dart';
import '../presentation/controllers/exam_builder_controller.dart';

class ExamBuilderBinding extends Bindings {
  @override
  void dependencies() {
    // Local Datasource
    Get.lazyPut<ExamBuilderLocalDataSource>(
      () => ExamBuilderLocalDataSourceImpl(),
    );

    // Repository implementation
    Get.lazyPut<ExamBuilderRepository>(
      () => ExamBuilderRepositoryImpl(
        localDataSource: Get.find<ExamBuilderLocalDataSource>(),
      ),
    );

    // Use cases
    Get.lazyPut<GetExamsUseCase>(
      () => GetExamsUseCase(Get.find<ExamBuilderRepository>()),
    );
    Get.lazyPut<GetBuilderActivitiesUseCase>(
      () => GetBuilderActivitiesUseCase(Get.find<ExamBuilderRepository>()),
    );
    Get.lazyPut<SaveExamUseCase>(
      () => SaveExamUseCase(Get.find<ExamBuilderRepository>()),
    );
    Get.lazyPut<DeleteExamUseCase>(
      () => DeleteExamUseCase(Get.find<ExamBuilderRepository>()),
    );

    // Controller
    Get.put<ExamBuilderController>(
      ExamBuilderController(
        getExamsUseCase: Get.find<GetExamsUseCase>(),
        getBuilderActivitiesUseCase: Get.find<GetBuilderActivitiesUseCase>(),
        saveExamUseCase: Get.find<SaveExamUseCase>(),
        deleteExamUseCase: Get.find<DeleteExamUseCase>(),
      ),
    );
  }
}

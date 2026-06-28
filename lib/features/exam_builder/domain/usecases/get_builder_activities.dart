import '../entities/builder_activity_entity.dart';
import '../repositories/exam_builder_repository.dart';

class GetBuilderActivitiesUseCase {
  final ExamBuilderRepository repository;

  GetBuilderActivitiesUseCase(this.repository);

  Future<List<BuilderActivityEntity>> call() async {
    return await repository.getBuilderActivities();
  }
}

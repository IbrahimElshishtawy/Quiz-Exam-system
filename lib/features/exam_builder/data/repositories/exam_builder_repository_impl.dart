import '../../domain/entities/exam_draft_entity.dart';
import '../../domain/entities/builder_activity_entity.dart';
import '../../domain/repositories/exam_builder_repository.dart';
import '../datasources/exam_builder_local_datasource.dart';

class ExamBuilderRepositoryImpl implements ExamBuilderRepository {
  final ExamBuilderLocalDataSource localDataSource;

  ExamBuilderRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ExamDraftEntity>> getExams() async {
    return await localDataSource.getExams();
  }

  @override
  Future<List<BuilderActivityEntity>> getBuilderActivities() async {
    return await localDataSource.getBuilderActivities();
  }

  @override
  Future<void> saveExam(ExamDraftEntity exam) async {
    await localDataSource.saveExam(exam);
  }

  @override
  Future<void> deleteExam(String id) async {
    await localDataSource.deleteExam(id);
  }
}

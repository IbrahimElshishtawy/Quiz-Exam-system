import '../entities/notification_entity.dart';
import '../repositories/student_dashboard_repository.dart';

class GetNotifications {
  final StudentDashboardRepository repository;

  GetNotifications(this.repository);

  Future<List<NotificationEntity>> call() async {
    return await repository.getNotifications();
  }
}

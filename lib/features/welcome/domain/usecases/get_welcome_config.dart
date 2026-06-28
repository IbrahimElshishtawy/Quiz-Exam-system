import '../entities/welcome_config_entity.dart';
import '../repositories/welcome_repository.dart';

class GetWelcomeConfig {
  final WelcomeRepository repository;

  GetWelcomeConfig(this.repository);

  Future<WelcomeConfigEntity?> call() async {
    return await repository.getWelcomeConfig();
  }
}

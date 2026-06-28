import '../entities/welcome_config_entity.dart';
import '../repositories/welcome_repository.dart';

class SaveWelcomeConfig {
  final WelcomeRepository repository;

  SaveWelcomeConfig(this.repository);

  Future<void> call(WelcomeConfigEntity config) async {
    await repository.saveWelcomeConfig(config);
  }
}

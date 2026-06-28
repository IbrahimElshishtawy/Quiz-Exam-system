import '../entities/welcome_config_entity.dart';

abstract class WelcomeRepository {
  Future<WelcomeConfigEntity?> getWelcomeConfig();
  Future<void> saveWelcomeConfig(WelcomeConfigEntity config);
}

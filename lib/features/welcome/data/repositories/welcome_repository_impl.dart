import '../../domain/entities/welcome_config_entity.dart';
import '../../domain/repositories/welcome_repository.dart';
import '../datasources/welcome_local_datasource.dart';

class WelcomeRepositoryImpl implements WelcomeRepository {
  final WelcomeLocalDataSource localDataSource;

  WelcomeRepositoryImpl({required this.localDataSource});

  @override
  Future<WelcomeConfigEntity?> getWelcomeConfig() async {
    return await localDataSource.getWelcomeConfig();
  }

  @override
  Future<void> saveWelcomeConfig(WelcomeConfigEntity config) async {
    await localDataSource.saveWelcomeConfig(config);
  }
}

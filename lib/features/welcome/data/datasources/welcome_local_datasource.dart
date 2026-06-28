import 'package:get_storage/get_storage.dart';
import '../../domain/entities/welcome_config_entity.dart';

abstract class WelcomeLocalDataSource {
  Future<WelcomeConfigEntity?> getWelcomeConfig();
  Future<void> saveWelcomeConfig(WelcomeConfigEntity config);
}

class WelcomeLocalDataSourceImpl implements WelcomeLocalDataSource {
  final GetStorage storage;
  static const String _langKey = 'selected_language';
  static const String _roleKey = 'selected_role';

  WelcomeLocalDataSourceImpl(this.storage);

  @override
  Future<WelcomeConfigEntity?> getWelcomeConfig() async {
    final String? lang = storage.read<String>(_langKey);
    final String? role = storage.read<String>(_roleKey);

    if (lang == null && role == null) {
      return null;
    }
    return WelcomeConfigEntity(
      languageCode: lang ?? 'ar', // Default to Arabic
      role: role ?? 'student',     // Default to student
    );
  }

  @override
  Future<void> saveWelcomeConfig(WelcomeConfigEntity config) async {
    await storage.write(_langKey, config.languageCode);
    await storage.write(_roleKey, config.role);
    // Also update global user_role for splash/middleware compatibility
    await storage.write('user_role', config.role);
  }
}

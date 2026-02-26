import 'package:flutter/foundation.dart';

class AppConfig {
  static const bool isDemoMode = bool.fromEnvironment('DEMO_MODE', defaultValue: false);

  static void validate() {
    if (isDemoMode && kReleaseMode) {
      throw Exception('SECURITY ALERT: Demo mode is enabled in release build! This is strictly prohibited.');
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class BaseController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // User left the app - trigger anti-cheat event
      if (kDebugMode) {
        print('Anti-cheat: App moved to background/inactive');
      }
    }
  }
}

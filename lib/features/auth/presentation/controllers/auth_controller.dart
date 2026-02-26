import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../routes/app_routes.dart';
import '../../../../core/network/dio_client.dart';

class AuthController extends GetxController {
  final DioClient dioClient;
  final storage = const FlutterSecureStorage();
  var isLoading = false.obs;

  AuthController(this.dioClient);

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      final response = await dioClient.dio.post('/auth/login', data: {
        'username': username,
        'password': password,
        'deviceId': 'mock_device_id', // Should get from device_info_plus
      });

      await storage.write(key: 'access_token', value: response.data['access_token']);
      await storage.write(key: 'refresh_token', value: response.data['refresh_token']);
      Get.offAllNamed(Routes.ROOM_JOIN);
    } catch (e) {
      Get.snackbar('Error', 'Login failed');
    } finally {
      isLoading.value = false;
    }
  }
}

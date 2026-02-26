import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as getx;

class DioClient {
  late Dio dio;
  final storage = const FlutterSecureStorage();

  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:3000',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Attempt refresh
          final success = await _refreshToken();
          if (success) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await storage.read(key: 'refresh_token');
      final deviceId = await storage.read(key: 'device_id');

      final response = await Dio().post('http://localhost:3000/auth/refresh', data: {
        'refresh_token': refreshToken,
        'device_id': deviceId,
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        await storage.write(key: 'access_token', value: response.data['access_token']);
        await storage.write(key: 'refresh_token', value: response.data['refresh_token']);
        return true;
      }
    } catch (e) {
      // Logout user
    }
    return false;
  }

  Future<Response> _retry(RequestOptions requestOptions) {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}

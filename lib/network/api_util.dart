import 'package:dio/dio.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/network/api_interceptors.dart';
import 'package:get/get.dart';

import 'api_client.dart';

class ApiUtil {
  static Dio? dio;

  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = 60000.milliseconds;
      dio!.interceptors.add(ApiInterceptors());
    }
    return dio!;
  }

  static ApiClient get apiClient {
    final apiClient = ApiClient(getDio(), baseUrl: AppConfigs.baseUrl);
    return apiClient;
  }
}

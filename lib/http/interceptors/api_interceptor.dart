import 'dart:io';

import 'package:dio/dio.dart';

import '../../constants.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = Constants.baseUrl;
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    options.headers['sw-access-key'] = 'SWSCYWNMWHVYOGKZQMNTYTC1QW';

    if (options.data is Map) {
      /// remove nulls from request body [options.data]
      (options.data as Map<dynamic, dynamic>).removeWhere((k, v) => v == null);
    }

    /// remove nulls from request queryParameters [options.queryParameters]
    if (options.extra['ignore-null'] != true && options.data is Map) {
      /// remove nulls from request body [options.data]

      clearDataRecursively(options.data);
    }

    return handler.next(options);
  }

  void clearDataRecursively(Map<String, dynamic> map) {
    for (final value in map.values) {
      if (value is Map<String, dynamic>) {
        clearDataRecursively(value);
      }
    }

    map.removeWhere(
      (key, value) =>
          value == null ||
          (value is List && value.isEmpty) ||
          key == 'runtimeType',
    );
  }
}

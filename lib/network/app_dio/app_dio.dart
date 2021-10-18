import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:ehviewer/core/global.dart';
import 'package:ehviewer/network/app_dio/http_config.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppDio with DioMixin implements Dio {
  AppDio({BaseOptions? options, DioHttpConfig? dioConfig}) {
    options ??= BaseOptions(
        baseUrl: dioConfig?.baseUrl ?? '',
        contentType: Headers.formUrlEncodedContentType,
        connectTimeout: dioConfig?.connectTimeout,
        sendTimeout: dioConfig?.sendTimeout,
        receiveTimeout: dioConfig?.receiveTimeout);
    this.options = options;

    // DioCacheManager
    final cacheOptions = CacheConfig(
      databasePath: Global.appSupportPath,
      baseUrl: dioConfig?.baseUrl,
      defaultRequestMethod: 'GET',
    );

    interceptors.add(DioCacheManager(cacheOptions).interceptor);

    if (kDebugMode) {
      interceptors.add(LogInterceptor(
          responseBody: false,
          error: true,
          requestHeader: false,
          request: true,
          requestBody: true));
    }

    interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: false,
        maxWidth: 120));

    if (dioConfig?.interceptors?.isNotEmpty ?? false) {
      interceptors.addAll(dioConfig?.interceptors ?? List.empty());
    }

    httpClientAdapter = DefaultHttpClientAdapter();

    if (dioConfig?.proxy?.isNotEmpty ?? false) {
      setProxy(dioConfig!.proxy!);
    }
  }

  setProxy(String proxy) {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // config the http client
      client.findProxy = (uri) {
        // proxy all request to localhost:8888
        return 'PROXY $proxy';
      };
      // you can also create a HttpClient to dio
      // return HttpClient();
    };
  }
}

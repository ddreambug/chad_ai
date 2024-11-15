import 'dart:developer';
import 'package:chad_ai/global_controllers/global_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioService extends GetxService {
  static final DioService _dioService = DioService._();

  DioService._();

  factory DioService() {
    return _dioService;
  }

  static const Duration timeoutInMilliseconds = Duration(seconds: 20);

  Dio getDio({
    Duration timeout = timeoutInMilliseconds,
    String? token,
    String? authorization,
  }) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'token': token,
      if (authorization != null) 'Authorization': authorization,
    };

    final dio = Dio(
      BaseOptions(
        headers: headers,
        baseUrl: GlobalController.to.baseUrl,
        connectTimeout: timeout,
        contentType: "application/json",
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(_authInterceptor());

    return dio;
  }

  Interceptor _authInterceptor() {
    return QueuedInterceptorsWrapper(
      onRequest: (reqOptions, handler) {
        log('${reqOptions.uri}', name: 'REQUEST URL');
        log('${reqOptions.headers}', name: 'HEADER');
        handler.next(reqOptions);
      },
      onError: (error, handler) {
        log(error.message.toString(), name: 'ERROR MESSAGE');
        log('${error.response}', name: 'RESPONSE');
        handler.next(error);
      },
      onResponse: (response, handler) {
        log('${response.data}', name: 'RESPONSE');
        handler.next(response);
      },
    );
  }
}

import 'package:dio/dio.dart';

class BlockingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.reject(
      DioException(
        requestOptions: options,
        message: 'Request Block',
      ),
    );
  }
}

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('id:2REQUEST');

    print('id: 2→ ${options.method} ${options.uri}');
    print('id: 2→ Headers: ${options.headers}');
    print('id: 2→ Query: ${options.queryParameters}');
    print('id: 2→ Data: ${options.data}');

    print('------Logging----------');
    print("Request Time: ${options.headers['X-Request-Time']}");
    print('Request Id: ${options.headers['X-Request-ID']}');

    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    print('RESPONSE');
    print('← ${response.statusCode} ${response.requestOptions.uri}');
    print('← Data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    print('id:3 ERROR');
    print('id: 3 ✕ ${err.requestOptions.method}');
    print('id: 3 ✕ ${err.requestOptions.uri}');
    print('id: 3 ✕ Type: ${err.type}');
    print('id: 3 ✕ Message: ${err.message}');
    print('id: 3 ✕ Status: ${err.response?.statusCode}');

    handler.next(err);
  }
}

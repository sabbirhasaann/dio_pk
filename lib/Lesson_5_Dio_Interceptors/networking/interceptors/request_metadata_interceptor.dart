import 'package:dio/dio.dart';

class RequestMetadataInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final requestId = DateTime.now().microsecondsSinceEpoch.toString();

    print("request metadata interceptor is called...");
    options.headers['X-App-Version'] = '1.0.0';
    options.headers['X-client'] = 'Flutter';
    options.headers['X-Request-Time'] = DateTime.now().toIso8601String();
    options.headers['X-Request-ID'] = requestId;
    options.extra['startTime'] = DateTime.now();

    handler.next(options);
  }
}

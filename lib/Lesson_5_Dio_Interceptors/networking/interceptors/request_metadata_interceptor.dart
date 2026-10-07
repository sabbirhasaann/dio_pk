import 'package:dio/dio.dart';

class RequestMetadataInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    print("request metadata interceptor is called...");
    options.headers['X-App-Version'] = '1.0.0';
    options.headers['X-client'] = 'Flutter';

    handler.next(options);
  }
}

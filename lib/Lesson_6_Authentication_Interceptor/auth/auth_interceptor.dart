import 'package:dio/dio.dart';

import './token_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required TokenStorage tokenStorage,
  }) : _tokenStorage = tokenStorage;

  final TokenStorage _tokenStorage;
  static const String requiresAuthKey = 'require';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final requiresAuth = options.extra[requiresAuthKey] as bool? ?? true;
    if (!requiresAuth) {
      handler.next(options);
      return;
    }

    final accessToken = await _tokenStorage.readAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      handler.next(options);
      return;
    }
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }
}

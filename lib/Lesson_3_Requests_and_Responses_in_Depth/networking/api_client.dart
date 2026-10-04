import 'package:dio/dio.dart';

class ApiClient {
  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com',
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          responseType: ResponseType.json,
        ),
      );

  final Dio _dio;

  Future<Response<dynamic>> getPosts({int? userId, int? limit}) async {
    return await _dio.get(
      '/posts',
      queryParameters: {
        'userId': ?userId,
        '_limit': ?limit,
      },
    );
  }

  Future<Response<dynamic>> getPost(int id) async {
    return await _dio.get(
      '/posts/$id',
    );
  }
}

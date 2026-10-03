import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

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

  Future<Response<dynamic>> getPost(int id) {
    return _dio.get(
      '/posts/$id',
    );
  }

  Future<Response<dynamic>> getPostsByUser(int userId) {
    return _dio.get(
      '/posts',
      queryParameters: {
        'userId': userId,
      },
    );
  }

  Future<Response<dynamic>> createPost({
    required String title,
    required String body,
    required int userId,
  }) {
    return _dio.post(
      '/posts',
      data: {
        'title': title,
        'body': body,
        'userId': userId,
      },
    );
  }
}

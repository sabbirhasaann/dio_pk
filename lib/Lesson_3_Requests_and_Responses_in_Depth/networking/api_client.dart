import 'package:dio/dio.dart';

import '../models/create_post.dart';
import '../models/post.dart';

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

  Future<Post> createPost(CreatePost post) async {
    final response = await _dio.post(
      '/posts',
      data: post.toJson(),
    );

    return Post.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<Response<dynamic>> updatePost({
    required int id,
    required String title,
    required String body,
    required int userId,
  }) async {
    return await _dio.put(
      '/post/$id',
      data: {
        'id': id,
        'title': title,
        'body': body,
        'userId': userId,
      },
    );
  }

  Future<Response<dynamic>> updatePostTitle({
    required int id,
    required String title,
  }) {
    return _dio.patch(
      '/posts/$id',
      data: {
        'title': title,
      },
    );
  }

  Future<Response<dynamic>> deletePost(int id) {
    return _dio.delete('/posts/$id');
  }

  Future<Response<dynamic>> headerAtRequestLevel() async {
    return _dio.get(
      '/posts',
      options: Options(
        headers: {
          'X-Vlient-Version': '1.0.0',
        },
      ),
    );
  }
}

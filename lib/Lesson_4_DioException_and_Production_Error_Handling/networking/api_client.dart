import 'package:dio/dio.dart';

import '../errors/dio_error_mapper.dart';

class ApiClient {
  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com',
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),

          // validateStatus: (status) {
          //   return status != null && status < 500;
          // },
        ),
      );

  final Dio _dio;
  final DioErrorMapper _errorMapper = const DioErrorMapper();
  CancelToken? _cancelToken;

  Future<Response<dynamic>> getValidPost() async {
    try {
      return await _dio.get('/posts/1');
    } on DioException catch (e) {
      throw _errorMapper.map(e);
    }
  }

  Future<Response<dynamic>> getMissingPost() async {
    try {
      return await _dio.get('/posts/999999999');
    } on DioException catch (e) {
      throw _errorMapper.map(e);
    }
  }

  Future<Response<dynamic>> getPostWithCancellation() async {
    _cancelToken = CancelToken();
    try {
      return await _dio.get(
        '/posts/1',
        cancelToken: _cancelToken,
      );
    } on DioException catch (e) {
      throw _errorMapper.map(e);
    }
  }

  void cancelRequest() {
    _cancelToken?.cancel();
  }
}

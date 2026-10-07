import 'package:dio/dio.dart';

import '../errors/dio_error_mapper.dart';
import './interceptors/logging_interceptor.dart';
import './interceptors/request_metadata_interceptor.dart';
// import './interceptors/blocking_interceptor.dart';

class ApiClient {
  late final Dio _dio;
  final DioErrorMapper _errorMapper = const DioErrorMapper();
  CancelToken? _cancelToken;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    _configureInterceptors();
  }

  void _configureInterceptors() {
    _dio.interceptors.add(
      RequestMetadataInterceptor(),
    );
    _dio.interceptors.add(
      LoggingInterceptor(),
    );
    // _dio.interceptors.add(
    //   BlockingInterceptor(),
    // );
  }

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
      await Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      return await _dio.get(
        '/posts/1',
        cancelToken: _cancelToken,
      );
    } on DioException catch (e) {
      print(e.type);
      throw _errorMapper.map(e);
    }
  }

  void cancelRequest() {
    _cancelToken?.cancel();
  }

  Future<Response<dynamic>> triggerServerError() async {
    try {
      return await _dio.get('/api/test/500/');
    } on DioException catch (e) {
      print("Response code: ${e.response?.statusCode}");
      print("Exception type: ${e.type}");
      throw _errorMapper.map(e);
    }
  }

  Future<Response<dynamic>> getPost(int id) async {
    try {
      return await _dio.get(
        '/posts/$id',
      );
    } on DioException catch (e) {
      print("id:1 Caught exception : $e");
      print("id:1 Exception type: ${e.type}");
      throw _errorMapper.map(e);
    }
  }
}

import 'package:dio/dio.dart';

class SearchClient {
  final Dio _dio;

  SearchClient(this._dio);

  CancelToken? _cancelToken;

  Future<Response<dynamic>> search(String query) async {
    _cancelToken?.cancel();
    final token = CancelToken();
    _cancelToken = token;
    return _dio.get(
      '/posts',
      queryParameters: {
        'q': query,
      },
      cancelToken: token,
    );
  }
}

import 'package:dio/dio.dart';
import 'package:dio_pk/Lesson_4_DioException_and_Production_Error_Handling/errors/app_exception.dart';

class DioErrorMapper {
  const DioErrorMapper();

  AppException map(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        return _mapStatusCode(
          exception.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return const UnknownException(
          'The request was cancelled.',
        );
      case DioExceptionType.badCertificate:
        return const NetworkException(
          'The server certificate could not be verified.',
        );
      default:
        return const UnknownException();
    }
  }

  AppException _mapStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return BadRequestException();
      case 401:
        return const UnauthorizedException();
      case 403:
        return const ForbiddenException();
      case 404:
        return const NotFoundException();
      case 500:
      case 502:
      case 503:
      case 504:
        return const ServerException();

      default:
        return const UnknownException();
    }
  }
}

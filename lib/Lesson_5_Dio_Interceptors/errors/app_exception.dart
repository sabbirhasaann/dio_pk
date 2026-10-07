sealed class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

class NetworkException extends AppException {
  const NetworkException([
    super.message = "Please check you internet connection.",
  ]);
}

class TimeoutException extends AppException {
  const TimeoutException([
    super.message = "The request take too long. Please try again.",
  ]);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Your session has expired. Please log in again.',
  ]);
}

class ForbiddenException extends AppException {
  const ForbiddenException([
    super.message = 'You do not have permission to perform this action.',
  ]);
}

class NotFoundException extends AppException {
  const NotFoundException([
    super.message = 'The requested resource was not found.',
  ]);
}

class BadRequestException extends AppException {
  const BadRequestException([
    super.message = 'The request was invalid.',
  ]);
}

class ServerException extends AppException {
  const ServerException([
    super.message = 'The server encountered a problem.',
  ]);
}

class UnknownException extends AppException {
  const UnknownException([
    super.message = 'Something went wrong. Please try again.',
  ]);
}

import 'package:dio/dio.dart';

class DioCustomException implements Exception {
  late Map<String, dynamic> errorMessage;

  DioCustomException.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = {
          'errorType': 'Connection timed out',
          'errorMessage': dioException.response?.data['message']
        };
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = {
          'errorType': 'Request send timeout',
          'errorMessage': dioException.response?.data['message']
        };
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = {
          'errorType': 'Receiving timed occurred',
          'errorMessage': dioException.response?.data['message']
        };

        break;
      case DioExceptionType.badCertificate:
        errorMessage = {
          'errorType': 'Bad certificate',
          'errorMessage': dioException.response?.data['message']
        };

        break;
      case DioExceptionType.badResponse:
        errorMessage =
            _handleStatusCode(dioException.response?.statusCode, dioException);
        break;
      case DioExceptionType.cancel:
        errorMessage = {
          'errorType': 'Request to the server was canceled',
          'errorMessage': dioException.response?.data['message']
        };

        break;
      case DioExceptionType.connectionError:
        errorMessage = {
          'errorType': 'Connectioin error occurred',
          'errorMessage': dioException.response?.data['message']
        };

        break;
      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          errorMessage = {
            'errorType': 'No Internet',
            'errorMessage': dioException.response?.data['message']
          };
        }
        errorMessage = {
          'errorType': 'Unexpected error occurred',
          'errorMessage': dioException.response?.data['message']
        };

        break;
      default:
        errorMessage = {
          'errorType': 'Something went wrong',
          'errorMessage': dioException.response?.data['message']
        };

        break;
    }
  }

  Map<String, dynamic> _handleStatusCode(int? statusCode, DioException error) {
    switch (statusCode) {
      case 400:
        return {
          'errorType': 'Bad request',
          'errorMessage': error.response?.data['message']
        };
      case 401:
        return {
          'errorType': 'Authentication failed',
          'errorMessage': error.response?.data['message']
        };
      case 403:
        return {
          'errorType':
              'The authenticated user is not allowed to access the specified API endpoint',
          'errorMessage': error.response?.data['message']
        };

      case 404:
        return {
          'errorType': 'The requested resource does not exist',
          'errorMessage': error.response?.data['message']
        };

      case 405:
        return {
          'errorType':
              'Method not allowed. Please check the Allow header for the allowed HTTP methods',
          'errorMessage': error.response?.data['message']
        };
      case 415:
        return {
          'errorType':
              'Unsupported media type. The requested content type or version number is invalid',
          'errorMessage': error.response?.data['message']
        };

      case 422:
        return {
          'errorType': 'Data validation failed',
          'errorMessage': error.response?.data['message']
        };

      case 429:
        return {
          'errorType': 'Too many requests',
          'errorMessage': error.response?.data['message'] ?? ''
        };

      case 500:
        return {
          'errorType': 'Internel server error',
          'errorMessage': error.response?.data['message']
        };

      default:
        return {
          'errorType': 'Oops, something went wrong!',
          'errorMessage': error.response?.data['message']
        };
    }
  }

  @override
  String toString() => errorMessage['errorMessage'];
}

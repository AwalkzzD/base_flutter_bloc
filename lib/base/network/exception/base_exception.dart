import 'dart:io';

import 'package:base_flutter_bloc/remote/api_manager/api_manager.dart';

/// class for storing exception related data (error message, data, status code).
/// used in [APIManager] class.
class BaseException implements Exception {
  BaseException(
    this.error, {
    this.data = '',
    this.statusCode = -1,
  });

  final String data;

  final String? error;

  final int? statusCode;

  @override
  String toString() => error ?? '';

  /// method returns custom error message based on status code
  /// static method of [BaseException] class, used in [APIManager] class exception handling.
  static String getExceptionMessage(int statusCode) {
    String error = '';
    switch (statusCode) {
      case -1:
        error = "Unexpected Error!";
        break;
      case HttpStatus.notFound:
        error = "Invalid Resource Request.";
        break;
      case HttpStatus.movedPermanently:
        error = "The server is not responding!, Invalid path.";
        break;
      case HttpStatus.movedTemporarily:
        error = "The server is temporarily down or under maintenance.";
        break;
      case HttpStatus.badRequest:
        error = "Please check your request and make sure data is valid.";
        break;
      case HttpStatus.unauthorized:
        error = "Unauthorized Access.";
        break;
      case HttpStatus.forbidden:
        error = "Your are not allowed to access this resource.";
        break;
      case HttpStatus.unprocessableEntity:
        error = "Provided credentials are not valid.";
        break;
      case HttpStatus.tooManyRequests:
        error = "Please wait for while before trying again!";
        break;
      case HttpStatus.internalServerError:
        error = "Something went wrong! Try again later!";
        break;
      case HttpStatus.badGateway:
        error = "Bad Gateway.";
        break;
      case HttpStatus.serviceUnavailable:
        error = "Server is not responding currently.";
        break;
      default:
        error = "Something went wrong, Please try again later!";
    }
    return error;
  }
}

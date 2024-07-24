/// class for storing api response, status code, response status, and error message
/// used in [APIManager] class.
class BaseResponse {
  final int? statusCode;

  BaseResponse(this.statusCode);
}

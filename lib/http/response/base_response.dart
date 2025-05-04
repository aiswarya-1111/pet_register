abstract class BaseResponse {
  int status;
  String? message;
  String? error;

  BaseResponse({this.status = 200, this.message, this.error});
}

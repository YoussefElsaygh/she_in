
part 'base_response.g.dart';

class BaseResponse {
  String signature;
  Response response;

  BaseResponse({this.signature, this.response});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
}

class Response {
  String timeStamp;
  String apiCode;
  String channelCode;
  String traceId;
  dynamic result;
  String walletCurrency;
  String responseStatus;
  ResponseError responseError;

  Response(
    this.timeStamp,
    this.walletCurrency,
    this.apiCode,
    this.channelCode,
    this.traceId,
    this.result,
    this.responseStatus,
    this.responseError,
  );

  // this.responseStatus, this.responseError
  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);
}

class ResponseError {
  String errorMessage;
  String errorCode;
  String errorCategory;
  List<String> errorMsgList;

  ResponseError({this.errorMessage, this.errorCode, this.errorMsgList});

  factory ResponseError.fromJson(Map<String, dynamic> json) => _$ResponseErrorFromJson(json);
}

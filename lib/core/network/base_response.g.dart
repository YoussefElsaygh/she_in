// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse(
    signature: json['signature'] as String,
    response: json['response'] == null
        ? null
        : Response.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'response': instance.response,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    json['timeStamp'] as String,
    json['walletCurrency'] as String,
    json['apiCode'] as String,
    json['channelCode'] as String,
    json['traceId'] as String,
    json['result'],
    json['responseStatus'] as String,
    json['responseError'] == null
        ? null
        : ResponseError.fromJson(json['responseError'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'timeStamp': instance.timeStamp,
      'apiCode': instance.apiCode,
      'channelCode': instance.channelCode,
      'traceId': instance.traceId,
      'result': instance.result,
      'walletCurrency': instance.walletCurrency,
      'responseStatus': instance.responseStatus,
      'responseError': instance.responseError,
    };

ResponseError _$ResponseErrorFromJson(Map<String, dynamic> json) {
  return ResponseError(
    errorMessage: json['errorMessage'] as String,
    errorCode: json['errorCode'] as String,
    errorMsgList:
        (json['errorMsgList'] as List)?.map((e) => e as String)?.toList(),
  )..errorCategory = json['errorCategory'] as String;
}

Map<String, dynamic> _$ResponseErrorToJson(ResponseError instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'errorCode': instance.errorCode,
      'errorCategory': instance.errorCategory,
      'errorMsgList': instance.errorMsgList,
    };

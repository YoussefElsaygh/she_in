import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:she_in/core/constants/constant.dart';
import 'package:she_in/core/network/base_request.dart';
import 'package:she_in/core/network/base_response.dart';

class VericashApiParameters {
  String signature;
  String apiCode;
  Map<String, dynamic> payload;
  String apiPath;
  String channelCode;
  int timeStamp;
  String sessionId;

  VericashApiParameters(
      {@required this.apiCode, @required this.payload, this.timeStamp, this.sessionId = "", this.signature = ""});
}

class VericashNetwork extends BaseRequest {
  static final VericashNetwork _singleton = new VericashNetwork._internal();

  factory VericashNetwork() {
    return _singleton;
  }

  VericashNetwork._internal()
      : super(
          url: "URL", //API_BASE_URL.SANDBOX_BASE,
          headers: {
            'Content-Type': 'application/json',
            'Username': 'dWJh',
            'Password': 'MTIzNDU2Nzg5',
            'userId': '1234'
          },
          requestType: NETWORK_REQUEST_TYPE.POST,
        );

  Future<BaseResponse> sendVericashRequest(VericashApiParameters request, [String param = ""]) async {
    this.url = _buildBaseUrl();
    var body = _buildBody(request);
    BaseResponse response = await super.sendRequest(body, param);
    checkForError(response);
    return response;
  }

  void checkForError(BaseResponse response) {}

  Map<String, dynamic> _buildBody(VericashApiParameters request) {
    return {};
  }

  String _buildBaseUrl() {}
}

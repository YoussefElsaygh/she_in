import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:she_in/core/helpers/app_exceptions.dart';
import 'package:she_in/core/network/base_response.dart';

enum NETWORK_REQUEST_TYPE { GET, POST }
enum SERVER_SECURITY_TYPE { HTTP, HTTPS }

class BaseRequest {
  NETWORK_REQUEST_TYPE requestType;
  String url;
  Map<String, String> headers;

  BaseRequest(
      {this.url, this.requestType = NETWORK_REQUEST_TYPE.GET, this.headers});

  @override
  String toString() {
    return 'URL: $url\n'
        'Headers: $headers\n'
        'Request Type: ${requestType == NETWORK_REQUEST_TYPE.GET ? "GET" : "POST"}\n';
  }

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> sendRequest(Map<String, dynamic> reqBody,
      [String param = '']) async {
    var response;
    this.url = this.url + param;
    var requestEncoded = json.encode(reqBody);
    print("*****************Request******************");
    print(this.toString());
    print("Request Body:${json.encode(reqBody)}");
    try {
      if (requestType == NETWORK_REQUEST_TYPE.POST) {
        response = await http
            .post(url, body: requestEncoded, headers: headers)
            .timeout(
              Duration(seconds: 45),
            );
      } else {
        response = await http
            .get(url, headers: headers)
            .timeout(Duration(seconds: 45));
      }
      return _returnResponse(response);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw AppTimeOutException();
    } on FormatException catch (e) {
      print(e.message);
      throw InvalidInputException();
    } catch (e) {
      throw FetchDataException();
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        print(
            "**********Response************");
        log('${json.encode(_decoder.convert(response.body))}');
        return BaseResponse.fromJson(_decoder.convert(response.body));
      case 400:
        throw BadRequestException();
      case 401:
      case 403:
        throw UnauthorisedException();
      case 500:
      default:
//      print("**********Response************"+_decoder.convert(String.fromCharCodes(response.bodyBytes)));
        return BaseResponse.fromJson(
            _decoder.convert(String.fromCharCodes(response.bodyBytes)));
    }
  }
}

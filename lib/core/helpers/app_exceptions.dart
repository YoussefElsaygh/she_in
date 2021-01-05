import 'package:flutter/services.dart';

class FetchDataException extends PlatformException {
  FetchDataException([String code = "Error001"]) : super(message: "Error During Communication", code: code);
}

class BadRequestException extends PlatformException {
  BadRequestException([String code = "Error002"]) : super(message: "Invalid Request", code: code);
}

class UnauthorisedException extends PlatformException {
  UnauthorisedException([String code = "Error003"]) : super(message: "Unauthorised", code: code);
}

class InvalidInputException extends PlatformException {
  InvalidInputException([String code = "Error004"]) : super(message: "Invalid Input", code: code);
}

class AppTimeOutException extends PlatformException {
  AppTimeOutException([String code="Error005"]) : super(message: 'Time out please check your internet connection ', code: code);
}

class NoInternetException extends PlatformException {
  NoInternetException([String code="Error006"]) : super(message: "No internet Connection", code: code);
}

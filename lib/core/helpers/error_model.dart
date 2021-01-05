import 'package:meta/meta.dart';

class ErrorModel {
  String code;
  String message;

  ErrorModel({@required this.code, @required this.message});

  @override
  bool operator ==(Object other) {
    return other is ErrorModel && other.code == code && other.message == message;
  }
}

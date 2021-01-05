import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:she_in/core/helpers/formStatus.dart';

import 'error_model.dart';

class BaseState extends Equatable {
  final FormStatus formStatus;
  final ErrorModel errorModel;
  final String successMessage;

  BaseState({@required this.formStatus,this.errorModel, this.successMessage});

  @override
  List<Object> get props => [formStatus, successMessage, errorModel];

  BaseState copyWith({FormStatus formStatus, ErrorModel errorModel, String successMessage}) => BaseState(
      successMessage: successMessage ?? this.successMessage,
      errorModel: this.errorModel,
      formStatus: formStatus ?? this.formStatus);
}

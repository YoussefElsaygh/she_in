
import 'package:flutter/material.dart';
import 'package:she_in/core/ui/buttons/primary_button.dart';
import 'package:she_in/core/ui/dialogs/generic_dialog.dart';

class SuccessDialog<T> extends GenericDialog {
  SuccessDialog(
      {String title,
      List<IButton> buttons,
      bool willPopUp = false,
      DialogWidgetBuilder widgetsBuilder,
      Key key})
      : super(
            widgetsBuilder: widgetsBuilder,
            title: title,
            imagePath: 'assets/images/check-success.png',
            buttons: buttons,
            willPopUp: willPopUp,
            key: key);
}

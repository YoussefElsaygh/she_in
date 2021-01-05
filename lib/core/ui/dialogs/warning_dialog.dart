
import 'package:flutter/material.dart';
import 'package:she_in/core/ui/buttons/primary_button.dart';
import 'package:she_in/core/ui/dialogs/generic_dialog.dart';

class WarningDialog<T> extends GenericDialog {
  WarningDialog(
      {String title, List<IButton> buttons, bool willPopUp = false, DialogWidgetBuilder widgetsBuilder, Key key})
      : super(
            widgetsBuilder: widgetsBuilder,
            title: title,
            imagePath: 'assets/exclamation-mark.png',
            buttons: buttons,
            willPopUp: willPopUp,
            key: key);
}

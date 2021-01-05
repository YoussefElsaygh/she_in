
import 'package:flutter/material.dart';
import 'package:she_in/core/ui/buttons/primary_button.dart';
import 'package:she_in/core/ui/dialogs/generic_dialog.dart';

class HintDialog<T> extends GenericDialog {
  HintDialog(
      {String title,
        List<IButton> buttons,
        bool willPopUp = false,
        DialogWidgetBuilder widgetsBuilder,
        bool closeIcon = false,
        String imagePath ='assets/images/sign_up/system_msg.png',
        Key key})
      : super(
      widgetsBuilder: widgetsBuilder,
      title: title,
      imagePath: imagePath,
      buttons: buttons,
      willPopUp: willPopUp,
      closeIcon: closeIcon,
      key: key);
}

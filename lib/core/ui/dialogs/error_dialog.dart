
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:she_in/core/ui/buttons/primary_button.dart';
import 'package:she_in/core/ui/dialogs/generic_dialog.dart';

class ErrorDialog {
  static Future<dynamic> show(
      {BuildContext context,
      String message,
      String code = '',
      String buttonText,
      Function failAction,Function closeFunction}) async {
    GenericDialog(closeFunction: closeFunction!=null?closeFunction:null,
      imagePath: 'assets/images/newError.png',
      closeIcon: true,
      widgetsBuilder: (context) => Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            (message != null)
                ? Html(
                    data: message,
                  )
                : Text("error"),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: code != null
                  ? Text(
                      code,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    )
                  : Text(""),
            ),
          ],
        ),
      ),
      title: "Failed",
      willPopUp: true,
      buttons: [
        PrimaryButton(
          text: buttonText ?? "Ok",
          onPressed: () {
            (failAction != null) ? failAction() : Navigator.pop(context);
          },
        )
      ],
    ).show(context);
  }
}

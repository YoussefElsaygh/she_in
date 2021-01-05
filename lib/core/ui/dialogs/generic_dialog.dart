
import 'package:flutter/material.dart';
import 'package:she_in/core/ui/buttons/primary_button.dart';

typedef DialogWidgetBuilder<T> = Widget Function(BuildContext context);

class GenericDialog<T> extends StatelessWidget {
  final String title;
  final String imagePath;
  final DialogWidgetBuilder widgetsBuilder;
  final List<IButton> buttons;
  final bool willPopUp;
  final bool closeIcon;
  final Function closeFunction;

  const GenericDialog(
      {Key key,
      this.title,
      this.buttons,
      this.widgetsBuilder,
      this.willPopUp,
      this.imagePath,
      this.closeFunction,
      this.closeIcon = false})
      : super(key: key);

  Future<T> show(BuildContext context) async {
    return await showDialog<T>(
        context: context,
        builder: (context) {
          return this;
        });
  }

  Future<bool> _onWillPop() async {
    return willPopUp ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: (MediaQuery.of(context).size.width) * (3 / 4),
                  height: 5,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  // Text()
                  (closeIcon)
                      ? IconButton(
                          icon: Icon(Icons.close),
                          onPressed: closeFunction == null
                              ? () {
                                  Navigator.pop(context);
                                }
                              : closeFunction)
                      : Container()
                ]),
                (imagePath != null)
                    ? Image.asset(
                        imagePath,
                        height: 125,
                        width: 125,
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                (title != null)
                    ? Text(
                        title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        maxLines: 3,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      )
                    : Container(),
                if (widgetsBuilder != null)
                  Center(child: widgetsBuilder(context)),
                SizedBox(
                  height: 10,
                ),
                if (buttons != null)
                  for (int i = 0; i < buttons.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buttons[i] as Widget,
                    )
              ],
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
}

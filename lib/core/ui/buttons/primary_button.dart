import 'package:flutter/material.dart';
import 'package:she_in/core/ui/app_styles.dart';

abstract class IButton {}

class PrimaryButton extends StatelessWidget implements IButton {
  final VoidCallback onPressed;
  final Widget child;
  final String text;
  final double height;
  final bool hasBoxShadow;
  final bool whiteBorder;
  final bool fit;

  const PrimaryButton(
      {Key key,
      this.fit = false,
      @required this.onPressed,
      this.child,
      this.text = "",
      this.height = 50,
      this.whiteBorder = false,
      this.hasBoxShadow = false})
      : super(key: key);

  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth < 550.0 ? deviceWidth - 20 : deviceWidth * 0.7;

    return Container(
      width: (!fit) ? targetWidth : null,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[const Color(0xFFFFAB00), const Color(0xFFF18339), const Color(0xffEE2250)]),
          border: whiteBorder
              ? Border.all(
                  color: whiteBorder ? Colors.white : AppStyles.disabledButtonColor,
                )
              : null,
          boxShadow: hasBoxShadow
              ? [
                  BoxShadow(
                    color: AppStyles.primaryColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]
              : null,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: AppStyles.primaryColor),
      child: FlatButton(
        textColor: Colors.white,
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50.0)),
        color: Colors.transparent,
        disabledColor: Colors.white.withOpacity(0.5),
        disabledTextColor: Colors.white,
        onPressed: onPressed,
        child: child ??
            FittedBox(
                child: Text(
              text,
              style: Theme.of(context).textTheme.button.copyWith(color: Colors.white, fontSize: 18),
            )),
      ),
    );
  }
}

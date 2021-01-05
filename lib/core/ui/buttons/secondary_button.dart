
import 'package:flutter/material.dart';
import 'package:she_in/core/ui/app_styles.dart';
import 'package:she_in/core/ui/buttons/primary_button.dart';

class SecondaryButton extends StatelessWidget implements IButton {
  final Function onPressed;
  final Widget child;
  final String text;
  final double height;
  final bool fit;

  SecondaryButton({
    Key key,
    this.fit = false,
    @required this.onPressed,
    @required this.child,
    this.text = "",
    this.height = 50,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        deviceWidth < 550.0 ? deviceWidth - 20 : deviceWidth * 0.7;

    return Container(
      width: (!fit) ? targetWidth : null,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppStyles.primaryColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: FlatButton(
          color: Colors.transparent,
          onPressed: onPressed,
          child: child ??
              FittedBox(child:Text(
                text,
                style: Theme.of(context).textTheme.button.copyWith(
                    color: AppStyles.primaryColor, fontSize: 18),
              ))
      ),
    );
  }
}

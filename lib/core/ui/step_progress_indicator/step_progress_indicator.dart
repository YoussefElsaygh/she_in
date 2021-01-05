import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget{
  final double _height;
  final double _width;
  final BoxDecoration decoration;
  final List<String> _stepsText;
  final int _curStep;
  final Color _activeColor;
  final Color _inactiveColor;
  final double _dotRadius;
  final EdgeInsets padding;
  final double lineHeight;
  final TextStyle _headerStyle;
  final TextStyle _stepStyle;

  const StepProgressIndicator(
      List<String> stepsText,
      int curStep,
      double height,
      double width,
      double dotRadius,
      Color activeColor,
      Color inactiveColor,
      TextStyle headerStyle,
      TextStyle stepsStyle,
      {
        Key key,
        this.decoration,
        this.padding,
        this.lineHeight = 2.0,
      })  : _stepsText = stepsText,
        _curStep = curStep,
        _height = height,
        _width = width,
        _dotRadius = dotRadius,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _headerStyle = headerStyle,
        _stepStyle = stepsStyle,
        assert(curStep > 0 == true && curStep <= stepsText.length),
        assert(width > 0),
        assert(height >= 2 * dotRadius),
        assert(width >= dotRadius * 2 * stepsText.length),
        super(key: key);
  @override


  List<Widget> _buildDots() {
    var wids = <Widget>[];
    _stepsText.asMap().forEach((i, text) {
      var circleColor = (i == 0 || _curStep > i + 1)
          ? _activeColor
          : _inactiveColor;

      var lineColor = _curStep > i + 1
          ? _activeColor
          : _inactiveColor;

      wids.add(CircleAvatar(
        radius: _dotRadius,
        backgroundColor: circleColor,
      ));

      //add a line separator
      //0-------0--------0
      if (i != _stepsText.length - 1) {
        wids.add(
            Expanded(
                child: Container(height: lineHeight, color: lineColor,)
            )
        );
      }
    });

    return wids;
  }

  List<Widget> _buildText() {
    var wids = <Widget>[];
    _stepsText.asMap().forEach((i, text) {

      wids.add(Text(text, style: _stepStyle));
    });

    return wids;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        height: this._height,
        width: this._width,
        decoration: this.decoration,
        child: Column(
          children: <Widget>[
            Container(
                child: Center(
                    child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: (_curStep).toString(),
                                style: _headerStyle.copyWith(
                                  color: _activeColor,//this is always going to be active
                                ),
                              ),
                              TextSpan(
                                text: " / " + _stepsText.length.toString(),
                                style: _headerStyle.copyWith(
                                  color: _curStep == _stepsText.length
                                      ? _activeColor
                                      : _inactiveColor,
                                ),
                              ),
                            ]
                        )
                    )
                )
            ),
            Row(
              children: _buildDots(),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildText(),
            ),
          ],
        ));
  }
}
//class _StepProgressIndicatorState extends State<StepProgressIndicator>{
//  @override
//  Widget build(BuildContext context) {
//    throw UnimplementedError();
//  }
//
//}
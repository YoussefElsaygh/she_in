import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:she_in/core/ui/app_styles.dart';

typedef void CounterChangeCallback(num value);

class Counter extends StatefulWidget {

  final CounterChangeCallback onChanged;

  Counter({
    Key key,
    @required this.counterController,
    @required num initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    @required this.decimalPlaces,
    this.color,
    this.textStyle,
    this.step = 1,
    this.buttonSize = 25,
    this.isTextField = true,
    this.isRoundButton=false,
  })  : assert(initialValue != null),
        assert(minValue != null),
        assert(maxValue != null),
        assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedValue = initialValue,
        super(key: key);

  final TextEditingController counterController;

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// decimal places required by the counter
  final int decimalPlaces;

  // to make textField true or text
  final bool isTextField;

  final bool isRoundButton;

  ///Currently selected integer value
  num selectedValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  /// indicates the color of fab used for increment and decrement
  Color color;

  /// text syle
  TextStyle textStyle;


  final double buttonSize;

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.counterController.text=widget.selectedValue.toStringAsFixed(widget.decimalPlaces);
  }

  InputBorder loginBorderTextField()=>
      OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
        borderSide: BorderSide(
          width: 0.5,
          color: AppStyles.greyColor,
        ),
      );

  void _incrementCounter() {
    if (widget.selectedValue + widget.step <= widget.maxValue) {
      widget.onChanged((widget.selectedValue + widget.step));
      setState(() {
        widget.selectedValue=widget.selectedValue + widget.step;
        widget.counterController.text=widget.selectedValue.toStringAsFixed(widget.decimalPlaces);
      });
    }else{
      return null;
    }
  }

  void _decrementCounter() {
    if (widget.selectedValue - widget.step >= widget.minValue) {
      widget.onChanged((widget.selectedValue - widget.step));
      setState(() {
        widget.selectedValue=widget.selectedValue - widget.step;
        widget.counterController.text=widget.selectedValue.toStringAsFixed(widget.decimalPlaces);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    widget.color = widget.color ?? themeData.accentColor;
    widget.textStyle = widget.textStyle ?? new TextStyle(
      fontSize: 20.0,
    );

    return  FittedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.isRoundButton?
          FloatingActionButton(
            onPressed: (widget.selectedValue - widget.step >= widget.minValue)?_decrementCounter:null,
            child: Icon(Icons.remove,color:AppStyles.primaryColor ,),
            backgroundColor: Colors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(color: AppStyles.primaryColor),
            ),
          ):
          RaisedButton(
            onPressed: (widget.selectedValue - widget.step >= widget.minValue)?_decrementCounter:null,
            elevation: 2,
            child: Icon(Icons.remove,color:AppStyles.primaryColor ,),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: BorderSide(color: AppStyles.primaryColor)
            ),
            disabledColor: Colors.grey.withOpacity(0.2),
          ),
          new Container(
            width: 140,
            padding: EdgeInsets.all(4.0),
            child:widget.isTextField?
            TextField(
              controller: widget.counterController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(4.0),
                enabledBorder: loginBorderTextField(),
                focusedBorder: loginBorderTextField(),
                disabledBorder: loginBorderTextField(),
                errorBorder: loginBorderTextField(),
                focusedErrorBorder: loginBorderTextField(),
              ),

            ): Align(
              alignment: Alignment.center,
              child: Text(
                  '${num.parse((widget.selectedValue).toStringAsFixed(widget.decimalPlaces))}',
                  style: widget.textStyle
              ),
            ),
          ),
          widget.isRoundButton?
          FloatingActionButton(
            onPressed: (widget.selectedValue + widget.step <= widget.maxValue)?_incrementCounter:null,
            child: Icon(Icons.add,color: AppStyles.primaryColor),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
              side: BorderSide(color: AppStyles.primaryColor),
            ),
          ):
          RaisedButton(
            onPressed: (widget.selectedValue + widget.step <= widget.maxValue)?_incrementCounter:null,
            elevation: 2,
            child: Icon(Icons.add,color:AppStyles.primaryColor,),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(color: AppStyles.primaryColor),
            ),
            disabledColor: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
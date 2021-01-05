import 'package:flutter/material.dart';

class DropDown<T> extends StatelessWidget {
  final T initialValue;
  final List<T> list;
  final String labelText;
  final Function onChanged;
  final Color borderColor;
  final double containerHeight;

  DropDown(
      {@required this.initialValue,
      @required this.list,
      this.onChanged,
      this.labelText,
      this.borderColor,
      this.containerHeight,
      Key key})
      : super(key: key);

  _buildInputLabel() {
    return (labelText != null)
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16),
            child: Container(
              child: Text(
                labelText,
              ),
            ),
          )
        : Container();
  }

  Widget _buildDropDown(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        deviceWidth < 550.0 ? deviceWidth - 10 : deviceWidth * 0.7;
//    final targetPadding=deviceWidth-targetWidth;
    return Container(
//      decoration: BoxDecoration(
//        boxShadow: [
//          BoxShadow(
//            color:
//            Colors.grey,
//            blurRadius: 15.0, // soften the shadow
//            spreadRadius: 0, //extend the shadow
//          )
//        ],
//      ),

      height: this.containerHeight,
//       padding: EdgeInsets.symmetric(horizontal: 8.0),

//      constraints: BoxConstraints(minWidth: 0.2*deviceWidth, maxWidth: 0.45*deviceWidth),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: borderColor != null
              ? BorderSide(
                  color: borderColor, style: BorderStyle.solid, width: 0.4)
              : BorderSide.none,
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: DropdownButton<T>(
            value: initialValue,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            isExpanded: true,
            icon: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(Icons.arrow_drop_down),
            ),
            iconSize: 25,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            onChanged: (newValue) {
              onChanged(newValue);
            },
            items: list.map<DropdownMenuItem<T>>((T value) {
              return DropdownMenuItem<T>(
//              key: GlobalKey<FormFieldState>(),
                value: value,
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.center,
                ),
//              child: Padding(
//                padding: EdgeInsets.symmetric(horizontal:100),
//                child: Text(value.toString(),textAlign: TextAlign.center,),
//              ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildInputLabel(),
            _buildDropDown(context),
          ]),
    );
  }
}

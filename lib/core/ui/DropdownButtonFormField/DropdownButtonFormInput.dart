import 'package:flutter/material.dart';

class DropDownButtonFormInput extends StatefulWidget {
  String hintText;
  String selectedValue;
  List items;
  Function onChange;
  Function onValidation;
  Function onSave;
  bool autoValidate;
  final FocusNode focusNode;
  DropDownButtonFormInput(
      {@required this.hintText,
      @required this.selectedValue,
      @required this.items,
      this.focusNode,
      @required this.onChange,
      @required this.onValidation,
      @required this.onSave,
      @required this.autoValidate});

  @override
  _DropDownButtonFormInputState createState() =>
      _DropDownButtonFormInputState();
}

class _DropDownButtonFormInputState extends State<DropDownButtonFormInput> {
  FocusNode _myFocusNode;
  void initState() {
    _myFocusNode = (widget.focusNode == null) ? FocusNode() : widget.focusNode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text('${widget.hintText}'),
      autovalidate: widget.autoValidate,
      focusNode: _myFocusNode,
      value: widget.selectedValue,
      onChanged: (newValue) {
        widget.onChange(newValue);
      },
      validator: (String arg) {
        return widget.onValidation(arg);
      },
      onSaved: (String val) {
        widget.onSave(val);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        counterStyle: TextStyle(
          height: double.minPositive,
        ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Color.fromRGBO(226, 222, 223, 1),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.amber,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Color.fromRGBO(226, 222, 223, 1),
          ),
        ),
        labelStyle: TextStyle(
          color: _myFocusNode.hasFocus ? Colors.amber : Color(0xffb9b7b7),
        ),
        alignLabelWithHint: true,
      ),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.black87),
      items: widget.items.map<DropdownMenuItem<String>>((currentItem) {
        return DropdownMenuItem(
          child: new Text(currentItem),
          value: currentItem,
        );
      }).toList(),
    );
  }
}

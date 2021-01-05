import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:she_in/core/helpers/validators.dart';
import 'package:she_in/core/localization/app_localization.dart';

class PasswordInput extends StatefulWidget {
  final FormFieldValidator<String> validationMethod;
  final String placeHolder;
  final TextInputAction textInputAction;
  final VoidCallback onEditingComplete;
  final FocusNode focusNode;
  final Key passwordInputKey;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final String semanticsLabelKey;
  final String errorLabelKey;
  final bool enable;
  final TextAlign textAlign;

  PasswordInput(
      {this.enable = true,
      this.validationMethod,
      this.placeHolder = '',
      this.textInputAction = TextInputAction.next,
      this.onEditingComplete,
      this.passwordInputKey,
      this.textEditingController,
      this.onChanged,
      this.focusNode,
      @required this.semanticsLabelKey,
      this.errorLabelKey,this.textAlign,
      Key key})
      : super(key: key);

  @override
  _PasswordInputState createState() => new _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  // this variable is used for the disable & enable of showing the password and change icon due to it
  bool _passwordVisibility = true;
  FocusNode _myFocusNode;
  Key _passwordInputKey;
  TextEditingController _textController;
  bool _changedFirstTimeFlag;

  @override
  void initState() {
    _passwordInputKey = (widget.passwordInputKey == null) ? Key('password') : widget.passwordInputKey;
    _myFocusNode = (widget.focusNode == null) ? FocusNode() : widget.focusNode;
    _textController = (widget.textEditingController == null) ? TextEditingController() : widget.textEditingController;
    _changedFirstTimeFlag = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth < 550.0 ? deviceWidth - 10 : deviceWidth * 0.7;
    return _textFormField();
  }

  ///* description: _textFormField function is for return the part of input widget with all UI behaviors for it
  _textFormField() {
    return Semantics(
      label: widget.semanticsLabelKey,
      child: TextFormField(obscureText:_passwordVisibility ,
        textAlign: widget.textAlign ?? TextAlign.start,
        cursorColor: Colors.amber,
        key: _passwordInputKey,
        textInputAction: widget.textInputAction,
        focusNode: _myFocusNode,
        controller: _textController,
        autovalidate: (_changedFirstTimeFlag) ? true : false,
        autocorrect: false,
        validator: (val) {
          if (val.isEmpty || val.trim().length <= 0) {
            return AppLocalizations.of(context).translate("error_please_enter") +
                AppLocalizations.of(context).translate(widget.placeHolder);
          }

          if (widget.validationMethod != null) return widget.validationMethod(val);
          return null;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                print("eye is entered $_passwordVisibility");
                _passwordVisibility = !_passwordVisibility;
                print("eye is after entered $_passwordVisibility");
              });
            },
            child: new Icon(_passwordVisibility ? Icons.visibility : Icons.visibility_off,color:Colors.black38),
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
          hintText: widget.placeHolder,
          alignLabelWithHint: true,
        ),
        onChanged: (val) {
          setState(() {
            _changedFirstTimeFlag = true;
          });
          (widget.onChanged != null) ? widget.onChanged(val) : () {};
        },
      ),
    );
  }
}

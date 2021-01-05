import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:she_in/core/localization/app_localization.dart';


class BasicInput extends StatefulWidget {
  final FormFieldValidator<String> validationMethod;
  final String placeHolder;
  final TextInputAction textInputAction;
  final VoidCallback onEditingComplete;
  final FocusNode focusNode;
  final Key basicInputKey;
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final String semanticsLabelKey;
  final String errorLabelKey;
  final bool enabled;
  final Widget icon;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final int maxLength;
  final TextAlign textAlign;
  final bool validateEmptyString;
  final bool validateZeroNumber;
  final bool clearIcon;

  BasicInput(
      {this.enabled = true,
        this.prefixIcon,
        this.clearIcon = false,
        this.suffixIcon,
        this.keyboardType = TextInputType.text,
        this.validationMethod,
        this.icon,
        this.placeHolder = '',
        this.textInputAction = TextInputAction.next,
        this.onEditingComplete,
        this.basicInputKey,
        this.textEditingController,
        this.onChanged,
        this.focusNode,
        this.semanticsLabelKey,
        this.errorLabelKey,
        Key key,
        this.maxLength,
        this.textAlign,
        this.validateEmptyString = false,
        this.validateZeroNumber = false})
      : super(key: key);

  @override
  _BasicInputState createState() => new _BasicInputState();
}

class _BasicInputState extends State<BasicInput> {
  // this variable is used for the disable & enable of showing the password and change icon due to it
  FocusNode _myFocusNode;
  Key _basicInputKey;
  TextEditingController _textController;
  bool _changedFirstTimeFlag;

  @override
  void initState() {
    _basicInputKey = (widget.basicInputKey == null) ? Key('basic_input') : widget.basicInputKey;
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
      child: TextFormField(
        textAlign: widget.textAlign ?? TextAlign.start,
        maxLength: widget.maxLength,
        cursorColor: Colors.amber,
        key: _basicInputKey,
        textInputAction: widget.textInputAction,
        enabled: widget.enabled,
        focusNode: _myFocusNode,
        controller: _textController,
        keyboardType: widget.keyboardType,
        autovalidate: (_changedFirstTimeFlag) ? true : false,
        autocorrect: false,
        validator: (val) {
          if (widget.validateEmptyString && val.isEmpty || val.trim().length <= 0) {
            return AppLocalizations.of(context).translate("error_please_enter") +
                AppLocalizations.of(context).translate(widget.placeHolder);
          }
          if (widget.validateZeroNumber && widget.keyboardType.index == 2 && val == "0") {
            return AppLocalizations.of(context).translate(widget.placeHolder) +
                AppLocalizations.of(context).translate("must_not_be_zero");
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
          prefixIcon: widget.prefixIcon,
          suffix: (widget.clearIcon && widget.textEditingController.text.isNotEmpty)?null:widget.suffixIcon,
          suffixIcon: (widget.clearIcon && widget.textEditingController.text.isNotEmpty)
              ? GestureDetector(
            child: Icon(Icons.clear),
            onTap: () {
              widget.textEditingController.clear();
              if (widget.onChanged != null) widget.onChanged("");
            },
          )
              : null,
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

  @override
  void dispose() {
    _myFocusNode.dispose();
    super.dispose();
  }
}

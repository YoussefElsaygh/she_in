
import 'dart:convert';

import 'package:intl/intl.dart';

class Validators {
  static isNumber(String val){
    if(val==null||val.isEmpty)
      return false;
    RegExp _reg=RegExp(r'^(\d*\.)?\d+$');
    return _reg.hasMatch(val);
  }
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9\\d!@#$%^&*(),.?":{}\''`~|<>;_+=^/\[\\]-]{7,}\$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    if(password.trim().length <= 0 && password.isEmpty)
      return "Please enter password";
    if(password.trim().length<7)
      return 'Invalid password,\n password should be minimum 7 characters length';
    if (!_passwordRegExp.hasMatch(password))
      return 'Invalid Password' ;
    return null;
  }
  static isValidPasswordLogin(String password) {
    if(password.trim().length <= 0 && password.isEmpty)
      return "Please enter password";
    return null;
  }
  static String emailVal(String input, String error) {
    final validCharacters = RegExp(
        r'[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}');
    if (!validCharacters.hasMatch(input)) {
      return error;
    }
    return null;
  }

  static String requirdVal(String input, String error) {
    if (input.isEmpty) {
      return error;
    }
    return null;
  }
  static bool required(String input) {
    if (input == null) {
      return false;
    }
    if (input.trim().length <= 0 && input.isEmpty) {
      return false;
    }
    if (input.replaceAll(RegExp(" "), '').length==0){
      return false;
    }
  }

  static String requirdValMustBe4Degits(String input, String error) {
    if (input.trim().length <= 0 && input.isEmpty) {
      return "input can't be empty";
    } else if (input.trim().length != 4) {
      return "must be 4 degits";
    }
  }

  static String numberVal(String input, String error) {
    final validCharacters = RegExp(r'(^[0-9]*$)');
    if (!validCharacters.hasMatch(input)) {
      return error;
    }
  }

  static String maxVal(String input, int max, String errMsg) {
    if (input.length >0&&max != null &&int.parse(input)>max) {
      return errMsg;
    }
  }

  static String minVal(String input, int min, String errMsg) {
    if (input.length > 0 && min != null && int.parse(input) < min) {
      return errMsg;
    }
  }

  static String maximumVal(String input, int min, int max, [String minError, String maxError]) {
    if (min != null && input.length < min && min != 0) {
      return minError;
    } else if (max != null && input.length > max && max != 0) {
      return maxError;
    }
  }

  static String noSpecialVal(String input, String error) {
    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    if (!validCharacters.hasMatch(input)) {
      return error;
    }
  }

  static String textVal(String input, String error) {
    final validCharacters = RegExp(r'(^[a-zA-Z ]*$)');
    if (!validCharacters.hasMatch(input)) {
      return error;
    }
  }

  static String phoneVal(String input, String error) {
    final validCharacters = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    if (!validCharacters.hasMatch(input)) {
      return error;
    }
  }

  static String validatePassword(String value, String error) {
    Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regex = new RegExp(pattern);
    String trimedValue = value.trim();
    if (trimedValue.isEmpty) {
      return 'Please enter password';
//    } else if (!regex.hasMatch(value)) {
//      return error;
    } else {
      return null;
    }
  }

  static String requirdValAndMatch(String input, String matchedInput, String errorEmpty, String errorMatched) {
    if (matchedInput.trim().length <= 0 && input.isEmpty) {
      return errorEmpty;
    } else {
      if (input != matchedInput) {
        return errorMatched;
      }
    }
  }

  static String validateRegistrationNumber(String value, String error, bool isRegistered) {
    if (value.trim().length <= 0 && value.isEmpty) {
      return 'Please enter mobile numer';
    } else if (isRegistered) {
      return error;
    } else {
      return null;
    }
  }

  static ValidJsonXpath checkValidJsonXpath(Map<String, dynamic> jsonObject, String xPathString) {

    ValidJsonXpath validityObject = ValidJsonXpath.fromJson({});

    if (xPathString.isNotEmpty && jsonObject != null) {

      Map flattenJsonObject(Map<String, dynamic> jsonObject, [String prefix = '']) {
        final Map<String, dynamic> jsonObjectFlatten = {};
        jsonObject.forEach((String key, dynamic value) {
          if (value is Map) {
            if(value.length!=0){
              jsonObjectFlatten['$prefix$key'] = value;
              jsonObjectFlatten.addAll(flattenJsonObject(value, '$prefix$key.'));
            }
          } else {
            jsonObjectFlatten['$prefix$key'] = value.toString();
          }
        });
        return jsonObjectFlatten;
      }

      Map jsonObjectFlatten = flattenJsonObject(jsonObject);

      if (jsonObjectFlatten.keys.contains(xPathString)){
        validityObject.value = jsonObjectFlatten[xPathString];
        validityObject.valid = true;
      }
    }
    return validityObject;
  }

  static String formatAmount (dynamic unformattedAmount) {
    dynamic amount = unformattedAmount;
    if (amount != null && amount !="" && amount is num ) {
      final numberFormat = new NumberFormat("#,##0.###", "en_US");
      amount = numberFormat.format(amount);
    }
    return amount;
  }
}
// To parse this JSON data, do
//
//     final validJsonXpath = validJsonXpathFromJson(jsonString);

ValidJsonXpath validJsonXpathFromJson(String str) => ValidJsonXpath.fromJson(json.decode(str));

String validJsonXpathToJson(ValidJsonXpath data) => json.encode(data.toJson());

class ValidJsonXpath {
  ValidJsonXpath({
    this.valid,
    this.value,
  });

  bool valid;
  dynamic value;

  factory ValidJsonXpath.fromJson(Map<String, dynamic> json) => ValidJsonXpath(
    valid: json["valid"] == null ? false : json["valid"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "valid": valid == null ? false : valid,
    "value": value == null ? null : value,
  };
}

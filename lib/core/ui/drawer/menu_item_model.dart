import 'package:flutter/material.dart';

class MenuItemModel {
  final String title;
  final Widget icon;
  final Function (BuildContext context) tagAction;
  final  bool isExpanded;
  final List<MenuItemModel> subItems;

  MenuItemModel(
      {@required this.title,
        @required this.icon,
        this.tagAction ,@required this.isExpanded,
        this.subItems});
}

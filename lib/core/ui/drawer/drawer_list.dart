import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:she_in/core/constants/constant.dart';
import 'package:she_in/core/navigation/app_navigation.dart';
import 'package:she_in/core/ui/drawer/menu_item_model.dart';

class SideMenuList {
  static SideMenuList _instance = new SideMenuList._internal();

  SideMenuList._internal();

  factory SideMenuList() => _instance;

  final List<MenuItemModel> menuList = [
    MenuItemModel(
        icon: Icon(
          Icons.home,
          color: Colors.orange,
        ),
        title: "Home",
        isExpanded: false,
        tagAction: (context) {
          AppNavigation.returnHome(context);
        }),
    MenuItemModel(
        icon: Icon(
          Icons.settings,
          color: Colors.orange,
        ),
        title: "Settings",
        isExpanded: false,
        tagAction: (context) {
          // AppNavigation.navigateToRouteName(context, ROUTES.SETTINGS);
        }),
    MenuItemModel(
        icon: Icon(
          Icons.exit_to_app,
          color: Colors.orange,
        ),
        title: "Logout",
        isExpanded: false,
        tagAction: (context) {
          AppNavigation.logout(context);
        }),
  ];
}

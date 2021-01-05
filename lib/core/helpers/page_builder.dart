import 'package:flutter/material.dart';

class PageBuilder {
  bool allowBackButtonInAppBar;
  bool appbar;
  bool enableDrawer;
  String appBarTitle;
  GlobalKey<ScaffoldState> scaffoldKey;
  Widget body;
  BuildContext context;
  Function backButtonCallBack;

  PageBuilder(
      {this.enableDrawer = false,
      @required this.scaffoldKey,
      this.backButtonCallBack,
      this.appBarTitle = "",
      this.appbar = true,
      @required this.context,
      this.allowBackButtonInAppBar = true,
      @required this.body});
}

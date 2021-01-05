import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget with PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;

  TitleBar({this.scaffoldKey, @required this.title, Key key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: scaffoldKey != null
          ? Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 2),
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back))),
          Container(
              padding: EdgeInsets.only(left: 2, right: 2),
              margin: EdgeInsets.only(right: 8),
              child: InkWell(
                  onTap: () => scaffoldKey.currentState.openDrawer(),
                  child: Icon(Icons.menu))),
          Container(
            child: Expanded(
              child: Text(title),
            ),
          )
        ],
      )
          : Text(title),
      automaticallyImplyLeading: scaffoldKey != null ? false : true,
      centerTitle: scaffoldKey != null ? true : false,
      backgroundColor:
      Colors.blue,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

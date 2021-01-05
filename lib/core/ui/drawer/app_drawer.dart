import 'package:flutter/material.dart';
import 'package:she_in/core/ui/drawer/menu_item_model.dart';

class AppDrawer extends StatefulWidget {
  final List<MenuItemModel> menuList;
  final String avatarImage;
  final Widget title;
  final String subTitle;

  AppDrawer({@required this.menuList,
      this.avatarImage, this.title, this.subTitle=''});

  @override
  _AppDrawerState createState() {
    return _AppDrawerState();
  }
}

class _AppDrawerState extends State<AppDrawer> {
  int _selectedIndex = 0;
  List<Widget> menuOptions = [];

  @override
  void initState() {
    super.initState();
    menuOptions.add(Container(
      height: 250,
      child: DrawerHeader(
        child: Padding(
          padding: EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.black,
//                      image: DecorationImage(
//                        image: NetworkImage(widget.avatarImage),
//                        fit: BoxFit.cover,
//                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              widget.title??Container(),

              SizedBox(
                height: 10,
              ),
              Text(
                widget.subTitle,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
      ),
    ));
    _createMenuItemsView(widget.menuList);
  }

  _createMenuItemsView(List<MenuItemModel> menuList) {
    for (int x = 0; x < menuList.length; x++) {
      MenuItemModel menuItem = menuList[x];
      if (menuItem.isExpanded) {
        List<Widget> subMenuOptions = [];
        for (int i = 0; i < menuItem.subItems.length; i++) {
          MenuItemModel subMenuItem = menuItem.subItems[i];
          subMenuOptions.add(new ListTile(
              contentPadding: EdgeInsets.only(left: 50),
              title: Text(subMenuItem.title,
                style: TextStyle(color: Colors.black),
              ),
              leading: subMenuItem.icon,
              selected: i == _selectedIndex,
              onTap: () => _onSelectItem(i, subMenuItem.tagAction)));
        }
        menuOptions.add(new ExpansionTile(
          title: Text(
            menuItem.title,
            style: TextStyle(color: Colors.black),

          ),
          children: subMenuOptions,
          leading: menuItem.icon,
        ));
      } else {
        menuOptions.add(new ListTile(
            title: Text(
              menuItem.title,
              style: TextStyle(color: Colors.black),
            ),
            leading: menuItem.icon,
            selected: x == _selectedIndex,
            onTap: () => _onSelectItem(x, menuItem.tagAction)));
      }
    }

    // return  menuOptions;
  }

  _onSelectItem(int index, Function tagAction) {
    setState(() {
      _selectedIndex = index;
      // _getDrawerItemScreen(_selectedIndex);
    });
    Navigator.of(context).pop(); // close the drawer
    tagAction(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListTileTheme(
        textColor: Colors.black,
        selectedColor: Colors.black,
        child: ListView(
          children: menuOptions,
        ),
      ),
    );
  }
}

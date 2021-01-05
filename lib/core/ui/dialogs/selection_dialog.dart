
import 'package:flutter/material.dart';
import 'package:she_in/core/ui/app_styles.dart';
import 'package:she_in/core/ui/dialogs/generic_dialog.dart';

class SelectionDialog {
  static Future<dynamic> show(
      {BuildContext context,String title,List<String>items,int selectedItemIndex}) async {
   return await GenericDialog<int>(
        closeIcon: true,
        title: title??"",
        widgetsBuilder: (context) => Column(
            children: items
                .asMap()
                .entries
                .map((e) => ListTile(
                selected: (e.key == selectedItemIndex),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                        constraints:
                        new BoxConstraints.loose(new Size(MediaQuery.of(context).size.width * 0.3, 100)),
                        child: Text(
                            (e.value ?? ""))),
                    if (e.key == selectedItemIndex)
                      Icon(
                        Icons.check,
                        color: AppStyles.primaryColor,
                      )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context, e.key);
                }))
                .toList())).show(context);

  }
}

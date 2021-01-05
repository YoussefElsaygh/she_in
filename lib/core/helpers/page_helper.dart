import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:she_in/core/helpers/page_builder.dart';
import 'package:she_in/core/ui/buttons/primary_button.dart';
import 'package:she_in/core/ui/dialogs/error_dialog.dart';
import 'package:she_in/core/ui/dialogs/success_dialog.dart';
import 'package:she_in/core/ui/drawer/app_drawer.dart';
import 'package:she_in/core/ui/drawer/drawer_list.dart';

abstract class PageHelper {
  buildPage(PageBuilder pageBuilder) {
    final double deviceWidth = MediaQuery.of(pageBuilder.context).size.width;
    final double targetWidth = deviceWidth < 550.0 ? deviceWidth - 20 : deviceWidth * 0.7;
    final double targetPadding = deviceWidth - targetWidth;
    final double deviceHeight = MediaQuery.of(pageBuilder.context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if (pageBuilder.backButtonCallBack != null && !EasyLoading.isShow) {
          pageBuilder.backButtonCallBack();
          return false;
        }
        return !EasyLoading.isShow;
      },
      child: Scaffold(
        key: pageBuilder.scaffoldKey,
        appBar: (pageBuilder.appbar)
            ? AppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                toolbarHeight: 80,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[const Color(0xFFF26C49), const Color(0xFFF18339), const Color(0xffEE2250)],
                    ),
                  ),
                ),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        (pageBuilder.allowBackButtonInAppBar)
                            ? Semantics(
                                label: "agent_vericash_page_back_button",
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (pageBuilder.backButtonCallBack != null)
                                      pageBuilder.backButtonCallBack();
                                    else
                                      Navigator.pop(pageBuilder.context);
                                  },
                                ),
                              )
                            : Container(),
                        (pageBuilder.enableDrawer)
                            ? Semantics(
                                label: "agent_vericash_page_menu_button",
                                child: IconButton(
                                  icon: Icon(Icons.menu),
                                  onPressed: () {
                                    pageBuilder.scaffoldKey.currentState.openDrawer();
                                    FocusScopeNode currentFocus = FocusScope.of(pageBuilder.context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, left: 10, bottom: 20),
                      child: Text(
                        pageBuilder.appBarTitle,
                        semanticsLabel: "agent_vericash_page_${pageBuilder.appBarTitle}_text",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                automaticallyImplyLeading: false,
                centerTitle: false,
//                  backgroundColor: Colors.orangeAccent,
              )
            : null,
        drawer: (pageBuilder.enableDrawer)
            ? AppDrawer(
                menuList: SideMenuList().menuList,
                title: Text("Title"),
              )
            : null,
        body: Padding(
          padding: EdgeInsets.only(left: targetPadding, right: targetPadding),
          child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(pageBuilder.context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: pageBuilder.body),
        ),
      ),
    );
  }

  buildSuccessDialog(BuildContext context, String successMessage, [Function(BuildContext) successAction]) async {
    await SuccessDialog<String>(
      willPopUp: false,
      title: "Success",
      widgetsBuilder: (context) => Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(successMessage),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      buttons: [
        PrimaryButton(
          text: 'ok',
          onPressed: () {
            (successAction != null)
                ? successAction(context)
                : Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        )
      ],
    ).show(context);
  }

  buildErrorDialog(BuildContext context, String message,
      [String code = '', String buttonText, Function failAction, Function closeFunction]) {
    ErrorDialog.show(
        context: context,
        buttonText: buttonText,
        message: message,
        closeFunction: closeFunction,
        code: code,
        failAction: failAction);
  }

  showLoadingIndicator(BuildContext context) {
    EasyLoading.show();
  }

  hideLoadingIndicator(BuildContext context) {
    EasyLoading.dismiss();
  }

  static showLoading(BuildContext context) {
    EasyLoading.show();
  }

  static hideLoading(BuildContext context) {
    EasyLoading.dismiss();
  }

  static showSuccess(BuildContext context, String successMessage, [Function(BuildContext) successAction]) async {
    await SuccessDialog<String>(
      willPopUp: false,
      title: "Success",
      widgetsBuilder: (context) => Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(successMessage),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      buttons: [
        PrimaryButton(
          text: 'ok',
          onPressed: () {
            (successAction != null)
                ? successAction(context)
                : Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        )
      ],
    ).show(context);
  }
}

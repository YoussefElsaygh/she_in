import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:she_in/core/helpers/app_routes.dart';

class AppNavigation {
  static navigateToRouteName(BuildContext context, String routeName) {
    if(routeName!=null ||AppRoutes.routes.containsKey(routeName))
      // 200ms over, navigate to a new page
//      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppRoutes.routes[routeName](context),
          ));
//      Navigator.pushNamed(context, routeName );
  }

  static navigateToPageWidget(BuildContext context, Widget widget) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
          ));
  }

  static logout(BuildContext context) {
    Get.toNamed(Navigator.defaultRouteName);
    // BlocProvider.of<AuthenticationBloc>(context).add(
    //   AuthenticationLoggedOut(),
    // );
  }

  static returnHome(BuildContext context) {
    Get.toNamed(Navigator.defaultRouteName);
  }

  static navigationToNormalPageWithBloc<T extends Bloc>(BuildContext context, T bloc, Widget page) {
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => BlocProvider.value(
              value: bloc,
              child: page,
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ));
  }
}

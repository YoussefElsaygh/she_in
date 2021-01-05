import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:she_in/core/helpers/app_routes.dart';
import 'package:she_in/core/localization/app_localization.dart';
import 'package:she_in/core/navigation/app_navigation.dart';
import 'package:she_in/core/ui/app_styles.dart';
import 'package:she_in/pages/mainPage.dart';
import 'core/helpers/app_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() {
    runApp(MultiProvider(
      providers: AppProviders.providers,
      child: App(),
    ));
  }, (dynamic error, dynamic stack) {
    print(error);
    print(stack);
  });
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..maskType = EasyLoadingMaskType.black
    ..radius = 10.0
    ..progressColor = AppStyles.primaryColor
    ..backgroundColor = Colors.transparent
    ..indicatorColor = AppStyles.primaryColor
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  initState() {
    super.initState();
  }




  // You'll probably want to wrap this function in a debounce

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      builder: EasyLoading.init(),
      navigatorKey: Get.key,
      theme:ThemeData(
        fontFamily: 'Robota-Regular',
        primaryColor: AppStyles.primaryColor,
        accentColor: AppStyles.greyColor,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            button: TextStyle(fontFamily: 'Robota-Regular'),
            headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            subtitle1: TextStyle(fontSize: 16),
            bodyText1: TextStyle(fontSize: 16)),
      ),
      supportedLocales: [Locale('en'), Locale('fr')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeListResolutionCallback: (locale, supportedLocales) {
        print(locale);
        print(supportedLocales);
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale[0].languageCode) {
            AppLocalizations.loadAll(supportedLocale);
            return supportedLocale;
          }
        }
        return Locale('en');
      },

      routes: AppRoutes.routes,
      home:MainPage()
    );
  }
}

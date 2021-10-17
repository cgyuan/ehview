import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:ehviewer/config/route/app_pages.dart';
import 'package:ehviewer/config/route/app_routes.dart';
import 'package:ehviewer/generated/l10n.dart';
import 'package:ehviewer/utils/get_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:oktoast/oktoast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded<Future<void>>(() async {
    getInit();
    runApp(DevicePreview(
      enabled: false,
      isToolbarVisible: true,
      builder: (context) => MyApp(),
    ));
  }, (Object error, StackTrace stackTrace) {});
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OKToast(child: cupertinorApp());
  }

  Widget cupertinorApp({CupertinoThemeData? theme, Locale? locale}) {
    return GetCupertinoApp(
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,
        initialRoute: EHRoutes.root,
        theme: theme,
        locale: locale,
        localizationsDelegates: const [L10n.delegate]);
  }
}

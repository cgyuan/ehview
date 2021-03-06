import 'package:ehviewer/generated/l10n.dart';
import 'package:ehviewer/pages/splash/controller/splash_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:line_icons/line_icons.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller;
    return CupertinoPageScaffold(
        child: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              LineIcons.cat,
              size: 150.0,
              color: Colors.grey,
            ),
            Text(
              L10n.of(context).app_title,
              style: const TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    ));
  }
}

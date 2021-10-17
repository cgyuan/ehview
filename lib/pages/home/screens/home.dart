import 'package:ehviewer/pages/home/controller/home_controller.dart';
import 'package:ehviewer/pages/home/screens/home_small.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.init(inContext: context);
    return WillPopScope(
        onWillPop: controller.doubleClickBack, child: HomeScreenSmall());
  }
}

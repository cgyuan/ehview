import 'package:ehviewer/pages/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeScreenSmall extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: controller.listBottomNavigationBarItem),
        tabBuilder: (BuildContext context, int index) {
          return controller.viewList[index];
        }));
  }
}

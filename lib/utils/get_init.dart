import 'package:ehviewer/pages/home/controller/home_controller.dart';
import 'package:get/get.dart';

void getInit() {
  Get.put(HomeController(), permanent: true);
}

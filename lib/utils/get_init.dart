import 'package:ehviewer/pages/home/controller/home_controller.dart';
import 'package:ehviewer/pages/home/pagers/gallery/controller/gallery_controller.dart';
import 'package:ehviewer/pages/home/pagers/setting/controller/setting_controller.dart';
import 'package:get/get.dart';

void getInit() {
  Get.put(HomeController(), permanent: true);
  Get.lazyPut(() => GalleryViewController(), fenix: true);
  Get.lazyPut(() => SettingController(), fenix: true);
}

import 'package:ehviewer/config/route/app_routes.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    print("hello");
    await Future<void>.delayed(const Duration(milliseconds: 800), () {
      Get.offNamed(EHRoutes.home);
    });
  }
}

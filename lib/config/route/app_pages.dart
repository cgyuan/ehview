import 'package:ehviewer/config/route/app_routes.dart';
import 'package:ehviewer/pages/home/screens/home.dart';
import 'package:ehviewer/pages/splash/binding/splash_binding.dart';
import 'package:ehviewer/pages/splash/screens/splash.dart';
import 'package:get/route_manager.dart';

class AppPages {
  static final List<GetPage> routes = <GetPage>[
    GetPage(
        name: EHRoutes.root,
        page: () => const SplashScreen(),
        binding: SplashBinding(),
        transition: Transition.fadeIn),
    GetPage(name: EHRoutes.home, page: () => const HomeScreen())
  ];
}

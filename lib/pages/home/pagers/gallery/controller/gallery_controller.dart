import 'package:ehviewer/config/route/app_routes.dart';
import 'package:ehviewer/constants/const.dart';
import 'package:ehviewer/generated/l10n.dart';
import 'package:ehviewer/pages/home/controller/tabpager_controller.dart';
import 'package:get/get.dart';

class GalleryViewController extends TabPagerController {
  GalleryViewController({int? cats}) : super(cats: cats);

  String get title {
    if (cats != null) {
      return EHConst.cats.entries
          .firstWhere(
              (element) => element.value == EHConst.sumCats - (cats ?? 0))
          .key;
    } else {
      return L10n.of(Get.context!).tab_gallery;
    }
  }

  @override
  void onInit() {
    tabTag = EHRoutes.gallery;
    super.onInit();
  }
}

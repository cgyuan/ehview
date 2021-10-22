import 'dart:io';

import 'package:ehviewer/constants/const.dart';
import 'package:ehviewer/core/store/get_store.dart';
import 'package:ehviewer/model/profile.dart';
import 'package:ehviewer/network/app_dio/http_config.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

DioHttpConfig ehDioConfig = DioHttpConfig(
    baseUrl: EHConst.EH_BASE_URL, cookiesPath: Global.appSupportPath);

class Global {
  // 是否第一次打开
  static bool isFirstOpen = false;
  static bool inDebugMode = false;
  static bool isFirstReOpenEhSetting = true;

  static Profile profile = kDefProfile;

  static String appSupportPath = '';
  static String appDocPath = '';
  static String tempPath = '';
  static late String extStorePath;
  static String dbPath = '';

  static Future<void> init() async {
    appSupportPath = (await getApplicationSupportDirectory()).path;
    appDocPath = (await getApplicationDocumentsDirectory()).path;
    tempPath = (await getTemporaryDirectory()).path;
    extStorePath = !Platform.isIOS
        ? (await getExternalStorageDirectory())?.path ?? ''
        : '';
    await GStore.init();
  }

  // 持久化Profile信息
  static void saveProfile() {
    final GStore gStore = Get.find<GStore>();
    gStore.profile = profile;
  }
}

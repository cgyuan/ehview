import 'dart:io';

import 'package:ehviewer/constants/const.dart';
import 'package:ehviewer/network/app_dio/http_config.dart';
import 'package:path_provider/path_provider.dart';

DioHttpConfig ehDioConfig = DioHttpConfig(
    baseUrl: EHConst.EH_BASE_URL, cookiesPath: Global.appSupportPath);

class Global {
  // 是否第一次打开
  static bool isFirstOpen = false;
  static bool inDebugMode = false;
  static bool isFirstReOpenEhSetting = true;

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
  }
}

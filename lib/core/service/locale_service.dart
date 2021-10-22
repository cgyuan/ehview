import 'dart:ui';

import 'package:ehviewer/core/global.dart';
import 'package:ehviewer/core/service/base_service.dart';
import 'package:ehviewer/model/profile.dart';
import 'package:get/get.dart';

class LocaleService extends ProfileService {
  RxString localCode = window.locale.toString().obs;

  Locale? get locale {
    final String localeSt = localCode.value;
    if (localeSt.isEmpty || localeSt == '_' || !localCode.contains('_')) {
      return null;
    }
    final List<String> t = localeSt.split('_');
    return Locale(t[0], t[1]);
  }

  bool get isLanguageCodeZh =>
      locale?.languageCode.startsWith('zh') ??
      window.locale.languageCode.startsWith('zh');

  @override
  void onInit() {
    super.onInit();
    final Profile profile = Global.profile;
    localCode.value = profile.locale;
    everProfile<String>(localCode, (value) {
      Global.profile = profile.copyWith(locale: value);
    });
  }
}

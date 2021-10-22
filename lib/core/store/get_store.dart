import 'dart:convert';

import 'package:ehviewer/model/profile.dart';
import 'package:get_storage/get_storage.dart';

import '../global.dart';

class GStore {
  static GetStorage _getStore([String container = 'GetStorage']) {
    return GetStorage(container, Global.appSupportPath);
  }

  static final _profileStore = () => _getStore('Profile');

  static Future<void> init() async {
    await _profileStore().initStorage;
  }

  set profile(Profile val) {
    ReadWriteValue('profile', '{}', _profileStore).val = jsonEncode(val);
  }
}

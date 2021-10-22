import 'package:ehviewer/core/global.dart';
import 'package:ehviewer/model/dns_config.dart';
import 'package:ehviewer/model/download_config.dart';
import 'package:ehviewer/model/eh_config.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileService extends GetxService {
  EhConfig get ehConfig => Global.profile.ehConfig;

  set ehConfig(EhConfig val) =>
      Global.profile = Global.profile.copyWith(ehConfig: val);

  DownloadConfig get downloadConfig => Global.profile.downloadConfig;
  set downloadConfig(DownloadConfig val) =>
      Global.profile = Global.profile.copyWith(downloadConfig: val);

  DnsConfig get dnsConfig => Global.profile.dnsConfig;
  set dnsConfig(DnsConfig val) =>
      Global.profile = Global.profile.copyWith(dnsConfig: val);

  Worker everProfile<T>(RxInterface<T> listener, ValueChanged<T> onChange) {
    return ever<T>(listener, (value) {
      onChange(value);
      Global.saveProfile();
    });
  }

  Worker everFromEunm<T>(
      RxInterface<T> listener, ValueChanged<String> onChange) {
    return ever<T>(listener, (value) {
      onChange(EnumToString.convertToString(value));
      Global.saveProfile();
    });
  }
}

import 'package:ehviewer/constants/const.dart';
import 'package:ehviewer/core/service/base_service.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../global.dart';
import 'locale_service.dart';

class EhConfigService extends ProfileService {
  RxBool isJpnTitle = false.obs;
  // RxBool isTagTranslat = false.obs;
  RxBool isGalleryImgBlur = false.obs;
  RxBool isSiteEx = false.obs;
  RxBool isFavLongTap = false.obs;
  RxInt catFilter = 0.obs;
  Rx<ListModeEnum> listMode = ListModeEnum.list.obs;
  // RxInt maxHistory = 100.obs;
  RxBool isSearchBarComp = true.obs;
  Rx<FavoriteOrder> favoriteOrder = FavoriteOrder.fav.obs;
  RxBool isSafeMode = false.obs;
  RxString tagTranslatVer = ''.obs;
  RxString lastFavcat = '0'.obs;
  RxBool isFavPicker = false.obs;
  RxBool isPureDarkTheme = false.obs;
  RxBool isClipboardLink = false.obs;
  RxBool commentTrans = false.obs;
  RxBool blurredInRecentTasks = true.obs;
  Rx<TagIntroImgLv> tagIntroImgLv = TagIntroImgLv.nonh.obs;

  final LocaleService localeService = Get.find();

  final _isTagTranslat = false.obs;
  bool get isTagTranslat {
    return localeService.isLanguageCodeZh && _isTagTranslat.value;
  }

  set isTagTranslat(bool val) => _isTagTranslat.value = val;

  String _lastClipboardLink = '';

  String? get lastShowFavcat => ehConfig.lastShowFavcat;
  set lastShowFavcat(String? value) {
    ehConfig = ehConfig.copyWith(lastShowFavcat: value);
  }

  String? get lastShowFavTitle => ehConfig.lastShowFavTitle;
  set lastShowFavTitle(String? value) {
    ehConfig = ehConfig.copyWith(lastShowFavTitle: value);
    Global.saveProfile();
  }

  /// 预载图片数量
  RxInt preloadImage = 5.obs;

  /// 下载线程数
  final RxInt _multiDownload = 3.obs;
  int get multiDownload => _multiDownload.value;
  set multiDownload(int val) => _multiDownload.value = val;

  final RxBool _allowMediaScan = false.obs;
  bool get allowMediaScan => _allowMediaScan.value;
  set allowMediaScan(bool val) => _allowMediaScan.value = val;

  /// 阅读相关设置
  /// 阅读方向
  Rx<ViewMode> viewMode = ViewMode.LeftToRight.obs;

  /// 自动锁定时间
  RxInt autoLockTimeOut = (-1).obs;

  /// 屏幕方向
  Rx<ReadOrientation> orientation = ReadOrientation.system.obs;

  /// 显示页面间隔
  RxBool showPageInterval = true.obs;

  // 震动总开关
  RxBool vibrate = true.obs;

  final RxBool _debugMode = false.obs;
  bool get debugMode => _debugMode.value;
  set debugMode(bool val) => _debugMode.value = val;

  final RxString _downloadLocatino = ''.obs;
  String get downloadLocatino => _downloadLocatino.value;
  set downloadLocatino(String val) => _downloadLocatino.value = val;

  // 自动翻页 _autoRead
  final RxBool _autoRead = false.obs;
  bool get autoRead => _autoRead.value;
  set autoRead(bool val) => _autoRead.value = val;

  // 翻页时间间隔 _turnPageInv
  final RxInt _turnPageInv = 3000.obs;
  int get turnPageInv => _turnPageInv.value;
  set turnPageInv(int val) => _turnPageInv.value = val;

  int debugCount = 3;

  final _tabletLayout = true.obs;
  bool get tabletLayout => _tabletLayout.value;
  set tabletLayout(bool val) => _tabletLayout.value = val;

  @override
  void onInit() {
    super.onInit();

    /// 预载图片数量
    preloadImage.value = downloadConfig.preloadImage ?? 5;
    everProfile<int>(preloadImage, (value) {
      downloadConfig = downloadConfig.copyWith(preloadImage: value);
    });

    // downloadLocatino
    downloadLocatino = downloadConfig.downloadLocation ?? '';
    everProfile<String>(_downloadLocatino, (value) {
      downloadConfig = downloadConfig.copyWith(downloadLocation: value);
    });

    multiDownload = (downloadConfig.multiDownload != null &&
            downloadConfig.multiDownload! > 0)
        ? downloadConfig.multiDownload!
        : 3;
    everProfile<int>(_multiDownload, (value) {
      downloadConfig = downloadConfig.copyWith(multiDownload: value);
    });

    allowMediaScan = downloadConfig.allowMediaScan ?? false;
    everProfile<bool>(_allowMediaScan, (value) {
      downloadConfig = downloadConfig.copyWith(allowMediaScan: value);
    });

    /// 阅读方向
    viewMode.value =
        EnumToString.fromString(ViewMode.values, ehConfig.viewModel) ??
            ViewMode.LeftToRight;
    everFromEunm(viewMode, (String value) {
      ehConfig = ehConfig.copyWith(viewModel: value);
    });

    isJpnTitle.value = ehConfig.jpnTitle;
    everProfile(isJpnTitle, (value) {
      ehConfig = ehConfig.copyWith(jpnTitle: value as bool);
      // logger.v('new ehConfig ${ehConfig.toJson()}');
    });

    isTagTranslat = ehConfig.tagTranslat ?? false;
    everProfile(_isTagTranslat,
        (value) => ehConfig = ehConfig.copyWith(tagTranslat: value as bool));

    isGalleryImgBlur.value = ehConfig.galleryImgBlur ?? false;
    everProfile(isGalleryImgBlur,
        (value) => ehConfig = ehConfig.copyWith(galleryImgBlur: value as bool));

    isSiteEx.value = ehConfig.siteEx ?? false;
    ehDioConfig.baseUrl =
        isSiteEx.value ? EHConst.EX_BASE_URL : EHConst.EH_BASE_URL;
    everProfile(isSiteEx, (value) {
      ehConfig = ehConfig.copyWith(siteEx: value as bool);
      ehDioConfig.baseUrl =
          isSiteEx.value ? EHConst.EX_BASE_URL : EHConst.EH_BASE_URL;
    });

    isFavLongTap.value = ehConfig.favLongTap ?? false;
    everProfile(isFavLongTap,
        (value) => ehConfig = ehConfig.copyWith(favLongTap: value as bool));

    catFilter.value = ehConfig.catFilter;
    everProfile(catFilter,
        (value) => ehConfig = ehConfig.copyWith(catFilter: value as int));

    listMode.value =
        EnumToString.fromString(ListModeEnum.values, ehConfig.listMode) ??
            ListModeEnum.list;
    everFromEunm(listMode,
        (String value) => ehConfig = ehConfig.copyWith(listMode: value));

    // maxHistory.value = ehConfig.maxHistory;
    // everProfile(maxHistory,
    //     (value) => ehConfig = ehConfig.copyWith(maxHistory: value as int));

    isSearchBarComp.value = ehConfig.searchBarComp ?? false;
    everProfile(isSearchBarComp,
        (value) => ehConfig = ehConfig.copyWith(searchBarComp: value as bool));

    favoriteOrder.value = EnumToString.fromString(
            FavoriteOrder.values, ehConfig.favoritesOrder) ??
        FavoriteOrder.fav;
    everFromEunm(favoriteOrder,
        (String value) => ehConfig = ehConfig.copyWith(favoritesOrder: value));

    tagTranslatVer.value = ehConfig.tagTranslatVer ?? '';
    everProfile(
        tagTranslatVer,
        (value) =>
            ehConfig = ehConfig.copyWith(tagTranslatVer: value as String));

    lastFavcat.value = ehConfig.lastFavcat ?? '';
    everProfile(lastFavcat,
        (value) => ehConfig = ehConfig.copyWith(lastFavcat: value as String));

    isFavPicker.value = ehConfig.favPicker ?? false;
    everProfile(isFavPicker,
        (value) => ehConfig = ehConfig.copyWith(favPicker: value as bool));

    isPureDarkTheme.value = ehConfig.pureDarkTheme ?? false;
    everProfile<bool>(isPureDarkTheme,
        (bool value) => ehConfig = ehConfig.copyWith(pureDarkTheme: value));

    isClipboardLink.value = ehConfig.clipboardLink ?? false;
    everProfile<bool>(isClipboardLink,
        (bool value) => ehConfig = ehConfig.copyWith(clipboardLink: value));

    commentTrans.value = ehConfig.commentTrans ?? false;
    everProfile<bool>(commentTrans,
        (bool value) => ehConfig = ehConfig.copyWith(commentTrans: value));

    // autoLockTimeOut
    autoLockTimeOut.value = ehConfig.autoLockTimeOut ?? -1;
    everProfile<int>(autoLockTimeOut,
        (int value) => ehConfig = ehConfig.copyWith(autoLockTimeOut: value));

    // showPageInterval
    showPageInterval.value = ehConfig.showPageInterval ?? false;
    everProfile<bool>(showPageInterval,
        (bool value) => ehConfig = ehConfig.copyWith(showPageInterval: value));

    // orientation
    orientation.value = EnumToString.fromString(
            ReadOrientation.values, ehConfig.favoritesOrder) ??
        ReadOrientation.system;
    everFromEunm(orientation,
        (String value) => ehConfig = ehConfig.copyWith(orientation: value));

    // vibrate
    vibrate.value = ehConfig.vibrate ?? true;
    everProfile<bool>(
        vibrate, (bool value) => ehConfig = ehConfig.copyWith(vibrate: value));

    // tagIntroImgLv
    tagIntroImgLv.value = EnumToString.fromString(
            TagIntroImgLv.values, ehConfig.tagIntroImgLv ?? 'nonh') ??
        TagIntroImgLv.nonh;
    everFromEunm(tagIntroImgLv,
        (String value) => ehConfig = ehConfig.copyWith(tagIntroImgLv: value));

    debugCount = ehConfig.debugCount ?? 3;
    if (!kDebugMode) {
      debugCount -= 1;
      ehConfig = ehConfig.copyWith(debugCount: debugCount);
    }
    if (debugCount > 0) {
      debugMode = ehConfig.debugMode ?? false;
    } else {
      debugMode = false;
    }
    Global.saveProfile();
    everProfile<bool>(_debugMode, (bool value) {
      ehConfig = ehConfig.copyWith(debugMode: value, debugCount: 3);
      if (value) {
        ehConfig = ehConfig.copyWith(debugCount: 3);
      } else {
        ehConfig = ehConfig.copyWith(debugCount: 0);
      }
      // resetLogLevel();
    });

    // 自动翻页 _autoRead
    autoRead = ehConfig.autoRead ?? false;
    everProfile<bool>(_autoRead,
        (bool value) => ehConfig = ehConfig.copyWith(autoRead: value));

    // 翻页时间间隔 _turnPageInv
    turnPageInv = ehConfig.turnPageInv ?? 3000;
    everProfile<int>(_turnPageInv,
        (int value) => ehConfig = ehConfig.copyWith(turnPageInv: value));

    tabletLayout = ehConfig.tabletLayout ?? true;
    everProfile<bool>(_tabletLayout,
        (bool value) => ehConfig = ehConfig.copyWith(tabletLayout: value));
  }
}

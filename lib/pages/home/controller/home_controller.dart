import 'package:ehviewer/config/route/app_routes.dart';
import 'package:ehviewer/generated/l10n.dart';
import 'package:ehviewer/pages/home/pagers/gallery/gallery_list_pager.dart';
import 'package:ehviewer/pages/home/pagers/setting/setting.dart';
import 'package:ehviewer/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

// Tab 图标大小
const double kIconSize = 24.0;

final TabPages tabPages = TabPages();

class TabPages {
  Map<String, Widget> get tabViews => <String, Widget>{
        EHRoutes.popular: CupertinoPageScaffold(child: Container()),
        EHRoutes.watched: CupertinoPageScaffold(child: Container()),
        EHRoutes.gallery: const GalleryListPager(),
        EHRoutes.favorite: CupertinoPageScaffold(child: Container()),
        EHRoutes.toplist: CupertinoPageScaffold(child: Container()),
        EHRoutes.history: CupertinoPageScaffold(child: Container()),
        EHRoutes.download: CupertinoPageScaffold(child: Container()),
        EHRoutes.setting: CupertinoPageScaffold(child: SettingPager()),
      };

  final Map<String, IconData> iconDatas = <String, IconData>{
    EHRoutes.popular: FontAwesomeIcons.fire,
    EHRoutes.watched: FontAwesomeIcons.solidEye,
    EHRoutes.gallery: FontAwesomeIcons.jira,
    EHRoutes.favorite: FontAwesomeIcons.solidHeart,
    EHRoutes.toplist: FontAwesomeIcons.listOl,
    EHRoutes.history: FontAwesomeIcons.history,
    EHRoutes.download: FontAwesomeIcons.download,
    EHRoutes.setting: FontAwesomeIcons.cog,
  };

  Map<String, String> get tabTitles => <String, String>{
        EHRoutes.popular:
            L10n.of(Get.find<HomeController>().tContext).tab_popular,
        EHRoutes.watched:
            L10n.of(Get.find<HomeController>().tContext).tab_watched,
        EHRoutes.gallery:
            L10n.of(Get.find<HomeController>().tContext).tab_gallery,
        EHRoutes.favorite:
            L10n.of(Get.find<HomeController>().tContext).tab_favorite,
        EHRoutes.toplist:
            L10n.of(Get.find<HomeController>().tContext).tab_toplist,
        EHRoutes.history:
            L10n.of(Get.find<HomeController>().tContext).tab_history,
        EHRoutes.download:
            L10n.of(Get.find<HomeController>().tContext).tab_download,
        EHRoutes.setting:
            L10n.of(Get.find<HomeController>().tContext).tab_setting,
      };

  Map<String, Widget> get tabIcons => iconDatas
      .map((key, value) => MapEntry(key, Icon(value, size: kIconSize)));
}

class HomeController extends GetxController {
  DateTime? lastPressedAt; //上次点击时间

  // BuildContext tContext = Get.context!;
  late BuildContext tContext;

  /// 需要初始化获取BuildContext 否则修改语言时tabitem的文字不会立即生效
  void init({required BuildContext inContext}) {
    // logger.d(' rebuild home');
    tContext = inContext;
  }

  bool get isSafeMode => false;

  // 默认显示在tabbar的view
  static const Map<String, bool> kDefTabMap = <String, bool>{
    EHRoutes.popular: true,
    EHRoutes.watched: false,
    EHRoutes.gallery: true,
    EHRoutes.favorite: true,
    EHRoutes.toplist: false,
    EHRoutes.download: true,
    EHRoutes.history: false,
  };

// 默认显示顺序 ?
  static const List<String> kTabNameList = <String>[
    EHRoutes.gallery,
    EHRoutes.popular,
    EHRoutes.watched,
    EHRoutes.favorite,
    EHRoutes.toplist,
    EHRoutes.download,
    EHRoutes.history,
  ];

  // 控制tab项顺序
  RxList<String> tabNameList = kTabNameList.obs;

  // 通过控制该变量控制tab项的开关
  RxMap<String, bool> tabMap = kDefTabMap.obs;

  // 需要显示的tab
  List<String> get _showTabs => isSafeMode
      ? <String>[
          EHRoutes.gallery,
          EHRoutes.setting,
        ]
      : _sortedTabList;

  List<BottomNavigationBarItem> get listBottomNavigationBarItem => _showTabs
      .map((e) => BottomNavigationBarItem(
            icon: (tabPages.tabIcons[e])!,
            label: tabPages.tabTitles[e],
          ))
      .toList();

  List<Widget> get viewList =>
      _showTabs.map((e) => tabPages.tabViews[e]!).toList();

  List<String> get _sortedTabList {
    final List<String> _list = <String>[];
    for (final String key in tabNameList) {
      if (tabMap[key]!) {
        _list.add(key);
      }
    }
    // setting 必须显示
    _list.add(EHRoutes.setting);
    return _list;
  }

  Future<bool> doubleClickBack() async {
    if (lastPressedAt == null ||
        DateTime.now().difference(lastPressedAt!) >
            const Duration(seconds: 1)) {
      showToast(L10n.of(tContext).double_click_back);
      //两次点击间隔超过1秒则重新计时
      lastPressedAt = DateTime.now();
      return false;
    }
    return true;
  }
}

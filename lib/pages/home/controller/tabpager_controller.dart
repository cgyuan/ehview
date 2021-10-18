import 'package:ehviewer/core/enums/page_state.dart';
import 'package:ehviewer/model/gallery_item.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class TabPagerController extends GetxController
    with StateMixin<List<GalleryItem>> {
  TabPagerController({this.cats});

  int? cats;

  late String tabTag;

  RxInt curPage = 0.obs;
  int maxPage = 1;
  int nextPage = 1;

  final RxBool _isBackgroundRefresh = false.obs;

  bool get isBackgroundRefresh => _isBackgroundRefresh.value;

  set isBackgroundRefresh(bool val) => _isBackgroundRefresh.value = val;

  final Rx<PageState> _pageState = PageState.None.obs;

  PageState get pageState => _pageState.value;

  set pageState(PageState val) => _pageState.value = val;
}

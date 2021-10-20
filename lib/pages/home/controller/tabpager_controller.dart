import 'package:dio/dio.dart';
import 'package:ehviewer/core/enums/page_state.dart';
import 'package:ehviewer/core/error/error.dart';
import 'package:ehviewer/model/gallery_item.dart';
import 'package:ehviewer/model/gallery_list.dart';
import 'package:ehviewer/repository/fetch_list.dart';
import 'package:ehviewer/utils/toast.dart';
import 'package:flutter/cupertino.dart';
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

  final CancelToken cancelToken = CancelToken();

  String get currToplist => '15';

  final GlobalKey<SliverAnimatedListState> sliverAnimatedListKey =
      GlobalKey<SliverAnimatedListState>();

  int lastTopitemIndex = 0;

  @override
  void onReady() {
    super.onReady();
    firstLoad();
  }

  FetchListClient getFetchListClient(FetchParams fetchParams) {
    return DefaultFetchListClient(fetchParams: fetchParams);
  }

  Future<GalleryList?> fetchData({bool refresh = false}) async {
    final int _catNum = 0;

    final fetchConfig = FetchParams(
      cats: cats ?? _catNum,
      toplist: currToplist,
      refresh: refresh,
      cancelToken: cancelToken,
    );

    try {
      // final Future<GalleryList?>? rult = fetchNormal?.call(
      //   cats: cats ?? _catNum,
      //   toplist: currToplist,
      //   refresh: refresh,
      //   cancelToken: cancelToken,
      // );

      FetchListClient fetchListClient = getFetchListClient(fetchConfig);
      final Future<GalleryList?> rult = fetchListClient.fetch();

      return rult;
    } on EhError catch (eherror) {
      // logger.e('type:${eherror.type}\n${eherror.message}');
      showToast(eherror.message);
      rethrow;
    }
  }

  Future<void> firstLoad() async {
    try {
      final GalleryList? rult = await fetchData();
      print("firstLoad:" + rult!.gallerys![0].toJson().toString());
      if (rult == null) {
        return;
      }

      final List<GalleryItem> _listItem = rult.gallerys ?? [];
      // Api.getMoreGalleryInfo(_listItem);

      maxPage = rult.maxPage ?? 0;
      nextPage = rult.nextPage ?? 1;
      change(_listItem, status: RxStatus.success());
    } catch (err, stack) {
      // logger.e('$err\n$stack');
      change(null, status: RxStatus.error(err.toString()));
    }

    try {
      if (cancelToken.isCancelled) {
        return;
      }
      isBackgroundRefresh = true;
      await reloadData();
    } catch (_) {
    } finally {
      isBackgroundRefresh = false;
    }
  }

  Future<void> reLoadDataFirst() async {
    isBackgroundRefresh = false;
    if (!cancelToken.isCancelled) {
      cancelToken.cancel();
    }
    change(null, status: RxStatus.loading());
    onInit();
  }

  Future<void> reloadData() async {
    curPage.value = 0;
    final GalleryList? rult = await fetchData(
      refresh: true,
    );
    if (rult == null) {
      return;
    }

    maxPage = rult.maxPage ?? 0;
    nextPage = rult.nextPage ?? 1;
    change(rult.gallerys, status: RxStatus.success());
  }
}

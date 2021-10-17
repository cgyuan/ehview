import 'package:ehviewer/components/refresh.dart';
import 'package:ehviewer/constants/constants.dart';
import 'package:ehviewer/pages/home/pagers/gallery/controller/gallery_controller.dart';
import 'package:ehviewer/utils/cust_lib/persistent_header_builder.dart';
import 'package:ehviewer/utils/cust_lib/sliver/sliver_persistent_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class GalleryListPager extends StatefulWidget {
  const GalleryListPager({Key? key}) : super(key: key);

  @override
  _GalleryListPagerState createState() => _GalleryListPagerState();
}

class _GalleryListPagerState extends State<GalleryListPager> {
  final controller = Get.find<GalleryViewController>();

  @override
  Widget build(BuildContext context) {
    final Widget navigationBar = _HeaderBar(controller: controller);
    final Widget customScrollView = CustomScrollView(
      cacheExtent: kTabViewCacheExtent,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverFloatingPinnedPersistentHeader(
          delegate: SliverFloatingPinnedPersistentHeaderBuilder(
            minExtentProtoType: SizedBox(
              height: context.mediaQueryPadding.top,
            ),
            maxExtentProtoType: navigationBar,
            builder: (_, __, ___) => navigationBar,
          ),
        ),
        EhCupertinoSliverRefreshControl(
          // key: centerKey,
          onRefresh: () async {},
        ),
        SliverSafeArea(
          // key: centerKey,
          top: false,
          bottom: false,
          sliver: SliverAnimatedList(itemBuilder:
              (BuildContext context, int index, Animation<double> animation) {
            return const SizedBox.shrink();
          }),
        ),
      ],
    );
    return CupertinoPageScaffold(
      child: CupertinoScrollbar(
        child: customScrollView,
        controller: PrimaryScrollController.of(context),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final GalleryViewController controller;

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      transitionBetweenRoutes: false,
      padding: const EdgeInsetsDirectional.only(end: 4),
      middle: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(controller.title),
            Obx(() {
              if (controller.isBackgroundRefresh) {
                return const CupertinoActivityIndicator(radius: 14)
                    .paddingSymmetric(horizontal: 8);
              } else {
                return const SizedBox();
              }
            })
          ],
        ),
      ),
      leading: Container(
        padding: const EdgeInsets.only(left: 14, bottom: 2),
        child: const Icon(
          CupertinoIcons.ellipsis_circle,
          size: 24,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 搜索按钮
          CupertinoButton(
            minSize: 40,
            padding: const EdgeInsets.all(0),
            child: const Icon(
              LineIcons.search,
              size: 26,
            ),
            onPressed: () {
              // NavigatorUtil.showSearch();
            },
          ),
          // 筛选按钮
          CupertinoButton(
            minSize: 40,
            padding: const EdgeInsets.all(0),
            child: const Icon(
              LineIcons.filter,
              size: 26,
            ),
            onPressed: () {
              // logger.v('${EHUtils.convNumToCatMap(1)}');
              // showFilterSetting();
            },
          ),
          CupertinoButton(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CupertinoDynamicColor.resolve(
                        CupertinoColors.activeBlue, context),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() => Text(
                      '${controller.curPage.value + 1}',
                      style: TextStyle(
                          color: CupertinoDynamicColor.resolve(
                              CupertinoColors.activeBlue, context)),
                    )),
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}

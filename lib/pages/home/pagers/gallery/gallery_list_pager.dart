import 'package:ehviewer/components/refresh.dart';
import 'package:ehviewer/constants/constants.dart';
import 'package:ehviewer/pages/home/pagers/gallery/components/gallery_error_page.dart';
import 'package:ehviewer/pages/home/pagers/gallery/controller/gallery_controller.dart';
import 'package:ehviewer/utils/cust_lib/persistent_header_builder.dart';
import 'package:ehviewer/utils/cust_lib/sliver/sliver_persistent_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/gallery_header_bar.dart';

class GalleryListPager extends StatefulWidget {
  const GalleryListPager({Key? key}) : super(key: key);

  @override
  _GalleryListPagerState createState() => _GalleryListPagerState();
}

class _GalleryListPagerState extends State<GalleryListPager> {
  final controller = Get.find<GalleryViewController>();

  @override
  Widget build(BuildContext context) {
    final Widget navigationBar = HeaderBar(controller: controller);
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

  Widget _getGalleryList() {
    return controller.obx(
        (state) {
          return Container();
        },
        onLoading: SliverFillRemaining(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 50),
            child: const CupertinoActivityIndicator(radius: 14),
          ),
        ),
        onError: (err) {
          return SliverFillRemaining(
            child: Container(
              padding: const EdgeInsets.only(bottom: 50),
              child: GalleryErrorPage(
                onTap: controller.reLoadDataFirst,
              ),
            ),
          );
        });
  }
}

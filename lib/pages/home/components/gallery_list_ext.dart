import 'package:ehviewer/constants/const.dart';
import 'package:ehviewer/model/gallery_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'gallery_item.dart';

var mode = ListModeEnum.list.obs;

Widget getGalleryList(
  List<GalleryItem>? galleryItemBeans,
  tabTag, {
  int? maxPage,
  int? curPage,
  VoidCallback? loadMore,
  Key? key,
  Key? topKey,
  int? lastTopItemIndex,
}) {
  return Obx(() {
    switch (mode.value) {
      case ListModeEnum.list:
        return buildGallerySliverListView(
          galleryItemBeans ?? [],
          tabTag,
          maxPage: maxPage,
          curPage: curPage ?? 0,
          loadMord: loadMore,
          key: key,
          centerKey: topKey,
          lastTopitemIndex: lastTopItemIndex,
        );
      default:
        return buildGallerySliverListView(
          galleryItemBeans ?? [],
          tabTag,
          maxPage: maxPage,
          curPage: curPage ?? 0,
          loadMord: loadMore,
          key: key,
          centerKey: topKey,
          lastTopitemIndex: lastTopItemIndex,
        );
    }
  });
}

Widget buildGallerySliverListView(
  List<GalleryItem> galleryItemBeans,
  dynamic tabTag, {
  int? maxPage,
  int curPage = 0,
  VoidCallback? loadMord,
  Key? key,
  Key? centerKey,
  int? lastTopitemIndex,
}) {
  print('gallery length : ${galleryItemBeans.length}');
  return SliverAnimatedList(
    key: key,
    initialItemCount: galleryItemBeans.length,
    itemBuilder:
        (BuildContext context, int index, Animation<double> animation) {
      if (galleryItemBeans.length - 1 < index) {
        return const SizedBox.shrink();
      }
      final GalleryItem _item = galleryItemBeans[index];
      return buildGallerySliverListItem(
        _item,
        index,
        animation,
        tabTag: tabTag,
        centerKey: centerKey,
        oriFirstIndex: lastTopitemIndex,
      );
    },
  );
}

Widget buildGallerySliverListItem(
  GalleryItem item,
  int index,
  Animation<double> animation, {
  dynamic tabTag,
  int? oriFirstIndex,
  Key? centerKey,
}) {
  return _buildSliverAnimatedListItem(animation,
      child: _listItemWiget(item,
          tabTag: tabTag,
          centerKey: index == oriFirstIndex ? centerKey : null));
}

Widget _buildSliverAnimatedListItem(
  Animation<double> _animation, {
  required Widget child,
}) {
  return FadeTransition(
    opacity: _animation.drive(CurveTween(curve: Curves.easeIn)),
    child: SizeTransition(
      sizeFactor: _animation.drive(CurveTween(curve: Curves.easeIn)),
      child: child,
    ),
  );
}

Widget _listItemWiget(
  GalleryItem item, {
  dynamic tabTag,
  Key? centerKey,
}) {
  switch (mode.value) {
    case ListModeEnum.list:
      return GalleryItemWidget(
        key: centerKey ?? ValueKey(item.gid),
        galleryItem: item,
        tabTag: tabTag,
      );
    default:
      return GalleryItemWidget(
        key: centerKey ?? ValueKey(item.gid),
        galleryItem: item,
        tabTag: tabTag,
      );
  }
}

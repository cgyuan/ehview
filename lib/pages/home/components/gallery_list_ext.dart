import 'package:ehviewer/constants/const.dart';
import 'package:ehviewer/model/gallery_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

var mode = ListModeEnum.list.obs;

// Widget getGalleryList(
//   List<GalleryItem>? galleryItemBeans,
//   tabTag, {
//   int? maxPage,
//   int? curPage,
//   VoidCallback? loadMore,
//   Key? key,
//   Key? topKey,
//   int? lastTopItemIndex,
// }) {
//   return Obx(() {
//     switch (mode.value) {
//       case ListModeEnum.list:
//         break;
//       default:
//     }
//   });
// }

// Widget buildGallerySliverListView(
//   List<GalleryItem> gallerItemBeans,
//   dynamic tabTag, {
//   int? maxPage,
//   int curPage = 0,
//   VoidCallback? loadMord,
//   Key? key,
//   Key? centerKey,
//   int? lastTopitemIndex,
// }) {
//   return SliverAnimatedList(itemBuilder: (context, index, animation) {
//     if (gallerItemBeans.length - 1 < index) {
//       return const SizedBox.shrink();
//     }
//     final GalleryItem _item = gallerItemBeans[index];
//     return 
//   })
// }

// Widget buildGallerySliverListItem(
//   GalleryItem item,
//   int index,
//   Animation<double> animation, {
//     dynamic tabTag,
//     int? oriFirstIndex, 
//     Key? centerKey,
//   }
// ) {
//   return _buildSliverAnimatedListItem(
//     animation, 
//     child: 
//   );
// }

// Widget _buildSliverAnimatedListItem(
//   Animation<double> _animation, {
//   required Widget child,
// }) {
//   return FadeTransition(opacity: _animation.drive(CurveTween(curve: Curves.easeIn)),
//     child: SizeTransition(sizeFactor: _animation.drive(CurveTween(curve: Curves.easeIn)), child: child,),
//   );
// }

// Widget _listItemWidget(
//   GalleryItem item, {
//     dynamic tabTag,
//     Key? centerKey,
//   }
// ) {
//   switch (mode.value) {
//     case ListModeEnum.list:
      
//       break;
//     default:
//   }
// }

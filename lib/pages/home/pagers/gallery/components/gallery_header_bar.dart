import 'package:ehviewer/pages/home/pagers/gallery/controller/gallery_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({
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

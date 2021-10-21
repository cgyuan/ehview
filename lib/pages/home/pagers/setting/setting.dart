import 'package:ehviewer/generated/l10n.dart';
import 'package:ehviewer/pages/home/pagers/setting/controller/setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingPager extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    controller.initData(context);
    final String _title = L10n.of(context).tab_setting;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).brightness != Brightness.dark
          ? CupertinoColors.secondarySystemBackground
          : null,
      child: CustomScrollView(
        controller: controller.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            heroTag: 'setting',
            middle: FadeTransition(
              opacity: controller.animation,
              child: Text(
                _title,
              ),
            ),
            largeTitle: Row(
              children: [
                Text(
                  _title,
                ),
                const Spacer(),
              ],
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final _itemList = controller.itemList;
                  if (index < _itemList.length) {
                    return _itemList[index];
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

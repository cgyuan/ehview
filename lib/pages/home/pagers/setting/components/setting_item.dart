import 'package:ehviewer/config/theme/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingItems extends StatefulWidget {
  const SettingItems({
    required this.text,
    required this.icon,
    required this.route,
    this.topDivider = false,
    this.bottomDivider = true,
  });

  final String text;
  final IconData icon;
  final String route;
  final bool topDivider;
  final bool bottomDivider;

  @override
  _SettingItemState createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItems> {
  Color? _color;
  Color? _pBackgroundColor;

  @override
  void initState() {
    _color = CupertinoDynamicColor.resolve(
        EhDynamicColors.itemBackground.darkColor, context);
    _pBackgroundColor = _color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _updatePressedColor(),
      onTapUp: (_) {
        Future.delayed(
            const Duration(milliseconds: 100), () => _updateNormalColor());
      },
      onTap: () {
        Get.toNamed(widget.route);
      },
      onTapCancel: () => _updateNormalColor(),
      child: Container(
        color: _color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.topDivider) _settingItemDivider(),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(16, 8, 20, 8),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    size: 26.0,
                    color: CupertinoColors.systemGrey,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(widget.text),
                  ),
                  const Spacer(),
                  const Icon(
                    CupertinoIcons.forward,
                    color: CupertinoColors.systemGrey,
                  )
                ],
              ),
            ),
            if (widget.bottomDivider) _settingItemDivider(),
          ],
        ),
      ),
    );
  }

  /// 设置项分隔线
  Widget _settingItemDivider() {
    return Divider(
      height: 0.8,
      indent: 45.0,
      color:
          CupertinoDynamicColor.resolve(CupertinoColors.systemGrey4, context),
    );
  }

  void _updateNormalColor() {
    setState(() {
      _color = CupertinoDynamicColor.resolve(
          EhDynamicColors.itemBackground.darkColor, context);
    });
  }

  _updatePressedColor() {
    setState(() {
      _color =
          CupertinoDynamicColor.resolve(CupertinoColors.systemGrey2, context);
    });
  }
}

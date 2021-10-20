import 'dart:ui';

import 'package:ehviewer/constants/const.dart';

class EHUtils {
  static String getLangeage(String value) {
    for (final String key in EHConst.iso936.keys) {
      if (key.toUpperCase().trim() == value.toUpperCase().trim()) {
        return EHConst.iso936[key] ?? EHConst.iso936.values.first;
      }
    }
    return '';
  }
}

class ColorsUtil {
  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  /// alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8,
        (hex & 0x0000FF) >> 0, alpha);
  }

  static Color? hexStringToColor(String? hexString, {double alpha = 1}) {
    // 如果传入的十六进制颜色值不符合要求，返回默认值
    if (hexString == null ||
        hexString.length != 7 ||
        int.tryParse(hexString.substring(1, 7), radix: 16) == null) {
      // s = '#999999';
      return null;
    }

    final int _hex =
        int.parse(hexString.substring(1, 7), radix: 16) + 0xFF000000;

    return hexColor(_hex, alpha: alpha);
  }

  static Color? getTagColor(String? hexColor) {
    if (hexColor != null && hexColor.isNotEmpty) {
      // logger.d(' $hexColor');
      return hexStringToColor(hexColor);
    }
    return null;
  }
}

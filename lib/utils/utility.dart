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

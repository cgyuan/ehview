import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ehviewer/constants/const.dart';
import 'package:ehviewer/core/parser/gallery_list_parser.dart';
import 'package:ehviewer/model/gallery_list.dart';

import 'exception.dart';
import 'http_response.dart';

/// Response 解析
abstract class HttpTransformer {
  FutureOr<DioHttpResponse<dynamic>> parse(Response response);
}

class DefaultHttpTransformer extends HttpTransformer {
// 假设接口返回类型
//   {
//     "code": 100,
//     "data": {},
//     "message": "success"
// }

  @override
  FutureOr<DioHttpResponse> parse(Response response) {
    // if (response.data["code"] == 100) {
    //   return HttpResponse.success(response.data["data"]);
    // } else {
    // return HttpResponse.failure(errorMsg:response.data["message"],errorCode: response.data["code"]);
    // }

    return DioHttpResponse.success(response.data['data']);
  }

  /// 单例对象
  static final DefaultHttpTransformer _instance =
      DefaultHttpTransformer._internal();

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  DefaultHttpTransformer._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory DefaultHttpTransformer.getInstance() => _instance;
}

/// 画廊列表解析 - 收藏夹页
class FavoriteListHttpTransformer extends HttpTransformer {
  @override
  FutureOr<DioHttpResponse<GalleryList>> parse(
      Response<dynamic> response) async {
    final html = response.data as String;

    // 排序方式检查
    const FavoriteOrder order = FavoriteOrder.fav;
    // 排序参数
    final String _order = EHConst.favoriteOrder[order] ?? EHConst.FAV_ORDER_FAV;
    final bool isOrderFav = isFavoriteOrder(html);
    final bool needReOrder = isOrderFav ^ (order == FavoriteOrder.fav);

    // 列表样式检查 不符合则设置参数重新请求
    final bool isDml = isGalleryListDmL(html);

    if (!isDml) {
      return DioHttpResponse<GalleryList>.failureFromError(
          ListDisplayModeException());
    } else if (needReOrder) {
      return DioHttpResponse<GalleryList>.failureFromError(
          FavOrderException(order: _order));
    } else {
      final GalleryList gam = await parseGalleryList(html, isFavorite: true);
      return DioHttpResponse<GalleryList>.success(gam);
    }
  }
}

class GalleryListHttpTransformer extends HttpTransformer {
  @override
  FutureOr<DioHttpResponse<GalleryList>> parse(Response response) async {
    final html = response.data as String;
    // 列表样式检查 不符合则设置参数重新请求
    final bool isDml = isGalleryListDmL(html);
    if (isDml) {
      final GalleryList gam = await parseGalleryList(html);
      return DioHttpResponse<GalleryList>.success(gam);
    } else {
      return DioHttpResponse<GalleryList>.failureFromError(
          ListDisplayModeException());
    }
  }
}

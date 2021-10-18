import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:ehviewer/constants/const.dart';
import 'package:ehviewer/core/global.dart';
import 'package:ehviewer/model/favcat.dart';
import 'package:ehviewer/model/gallery_list.dart';
import 'package:ehviewer/repository/fetch_list.dart';
import 'package:flutter/cupertino.dart';

import 'app_dio/dio_http_cli.dart';

Options getCacheOptions({bool forceRefresh = false, Options? options}) {
  return buildCacheOptions(
    const Duration(days: 5),
    maxStale: const Duration(days: 7),
    forceRefresh: forceRefresh,
    options: options,
  );
}

Future<GalleryList?> getGallery({
  int? page,
  String? fromGid,
  String? serach,
  int? cats,
  bool refresh = false,
  CancelToken? cancelToken,
  GalleryListType? galleryListType,
  String? toplist,
  String? favcat,
  ValueChanged<List<Favcat>>? favCatList,
}) async {
  DioHttpClient dioHttpClient = DioHttpClient(dioConfig: ehDioConfig);
  late final String _url;
  switch (galleryListType) {
    case GalleryListType.watched:
      _url = '/watched';
      break;
    case GalleryListType.toplist:
      _url = '${EHConst.EH_BASE_URL}/toplist.php';
      break;
    case GalleryListType.favorite:
      _url = '/favorites.php';
      break;
    case GalleryListType.popular:
      _url = '/popular';
      break;
    default:
      _url = '/';
  }

  final isTopList = galleryListType == GalleryListType.toplist;
  final isFav = galleryListType == GalleryListType.favorite;
  final isPopular = galleryListType == GalleryListType.popular;

  final Map<String, dynamic> _params = <String, dynamic>{
    if (!isTopList && !isPopular) 'page': page ?? 0,
    if (isTopList) 'p': page ?? 0,
    if (!isTopList && !isPopular && !isFav) 'f_cats': cats,
    if (!isTopList && !isPopular && fromGid != null) 'from': fromGid,
    if (!(galleryListType == GalleryListType.watched) &&
        !isTopList &&
        !isPopular &&
        serach != null)
      'f_search': serach,
    if (isTopList && toplist != null && toplist.isNotEmpty) 'tl': toplist,
    if (isFav && favcat != null && favcat != 'a' && favcat.isNotEmpty)
      'favcat': favcat,
  };
}

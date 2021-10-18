import 'package:dio/dio.dart';
import 'package:ehviewer/model/gallery_list.dart';

enum GalleryListType {
  gallery,
  watched,
  toplist,
  favorite,
  popular,
}

enum SearchType {
  normal,
  watched,
  favorite,
}

class FetchParams {
  FetchParams({
    this.page,
    this.fromGid,
    this.serach,
    this.searchType = SearchType.normal,
    this.cats,
    this.refresh = false,
    this.cancelToken,
    this.favcat,
    this.toplist,
    this.galleryListType = GalleryListType.gallery,
  });
  int? page;
  String? fromGid;
  String? serach;
  int? cats;
  bool refresh = false;
  SearchType searchType = SearchType.normal;
  CancelToken? cancelToken;
  String? favcat;
  String? toplist;
  GalleryListType? galleryListType;
}

abstract class FetchListClient {
  FetchListClient({required this.fetchParams});
  FetchParams fetchParams;
  Future<GalleryList?> fetch();
}

class DefaultFetchListClient extends FetchListClient {
  DefaultFetchListClient({required FetchParams fetchParams})
      : super(fetchParams: fetchParams);

  @override
  Future<GalleryList?> fetch() async {}
}

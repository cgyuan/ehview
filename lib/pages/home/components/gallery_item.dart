import 'package:cached_network_image/cached_network_image.dart';
import 'package:ehviewer/components/blur_image.dart';
import 'package:ehviewer/components/rating_bar.dart';
import 'package:ehviewer/config/theme/theme_colors.dart';
import 'package:ehviewer/model/gallery_item.dart';
import 'package:blur/blur.dart';
import 'package:ehviewer/model/simple_tag.dart';
import 'package:ehviewer/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

const double kPaddingHorizontal = 12.0;
const double kPaddingVertical = 18.0;

const kCardRadius = 12.0;

/// 画廊列表项
/// 标题和tag需要随设置变化重构ui
class GalleryItemWidget extends StatelessWidget {
  const GalleryItemWidget(
      {Key? key, required this.galleryItem, required this.tabTag})
      : super(key: key);

  final GalleryItem galleryItem;
  final dynamic tabTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(child: _buildCardItem()),
    );
  }

  Widget _buildCardItem() {
    return Container(
      decoration: BoxDecoration(
          color: EhDynamicColors.itemBackground.darkColor,
          borderRadius: BorderRadius.circular(kCardRadius)),
      padding: const EdgeInsets.only(right: kPaddingHorizontal),
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 12),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // 封面图片
            _CoverImage(
              item: galleryItem,
              tabTag: tabTag,
            ),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
              children: [
                // 标题 provider
                _Title(item: galleryItem),
                // 上传者
                Text(
                  galleryItem.uploader ?? '',
                  style: const TextStyle(
                      fontSize: 12, color: CupertinoColors.systemGrey),
                ),
                // 标签
                TagBox(
                  simpleTags: galleryItem.simpleTags ?? [],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // 评分
                    Expanded(
                        child: _Rating(
                      rating: galleryItem.rating,
                      ratingFallBack: galleryItem.ratingFallBack,
                      colorRating: galleryItem.colorRating,
                    )),
                    // 收藏图标
                    _FavcatIcon(
                      galleryItem: galleryItem,
                    ),
                    // 图片数量
                    _Filecont(
                      translated: galleryItem.translated,
                      filecount: galleryItem.filecount,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // 类型
                    _Category(
                      category: galleryItem.category,
                    ),
                    // const Spacer(),
                    // 上传时间
                    Expanded(
                        child: _PostTime(
                      postTime: galleryItem.postTime,
                    )),
                  ],
                )
              ],
            ).paddingSymmetric(vertical: 4))
          ],
        ),
      ),
    );
  }
}

class _PostTime extends StatelessWidget {
  const _PostTime({Key? key, this.postTime}) : super(key: key);
  final String? postTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      postTime ?? '',
      textAlign: TextAlign.right,
      style: const TextStyle(fontSize: 12, color: CupertinoColors.systemGrey),
    ).paddingOnly(left: 8);
  }
}

class _Category extends StatelessWidget {
  const _Category({Key? key, required this.category}) : super(key: key);
  final String? category;

  @override
  Widget build(BuildContext context) {
    final Color _colorCategory = CupertinoDynamicColor.resolve(
        ThemeColors.catColor[category ?? 'default'] ??
            CupertinoColors.systemBackground,
        Get.context!);

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
        color: _colorCategory,
        child: Text(
          category ?? '',
          style: const TextStyle(
            fontSize: 14,
            height: 1,
            color: CupertinoColors.white,
          ),
        ),
      ),
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating({Key? key, this.ratingFallBack, this.rating, this.colorRating})
      : super(key: key);
  final double? ratingFallBack;
  final double? rating;
  final String? colorRating;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: StaticRatingBar(
            size: 16.0,
            rate: ratingFallBack ?? 0,
            radiusRatio: 1.5,
            colorLight: ThemeColors.colorRatingMap[colorRating?.trim() ?? 'ir'],
            colorDark: CupertinoDynamicColor.resolve(
                CupertinoColors.systemGrey3, Get.context!),
          ),
        ),
        Text(
          rating?.toString() ?? '',
          style: TextStyle(
            fontSize: 11,
            color: CupertinoDynamicColor.resolve(
                CupertinoColors.systemGrey, Get.context!),
          ),
        ),
      ],
    ).paddingOnly(right: 4);
  }
}

class _Filecont extends StatelessWidget {
  const _Filecont({Key? key, this.translated, this.filecount})
      : super(key: key);
  final String? translated;
  final String? filecount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text(
            translated ?? '',
            style: const TextStyle(
                fontSize: 12, color: CupertinoColors.systemGrey),
          ),
        ),
        const Icon(
          Icons.panorama,
          size: 13,
          color: CupertinoColors.systemGrey,
        ),
        Container(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            filecount ?? '',
            style: const TextStyle(
                fontSize: 12, color: CupertinoColors.systemGrey),
          ),
        ),
      ],
    );
  }
}

class _FavcatIcon extends StatelessWidget {
  _FavcatIcon({Key? key, required this.galleryItem}) : super(key: key);
  final GalleryItem galleryItem;

  final RxBool isFav = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Container(
          child: isFav.value
              ? Container(
                  padding: const EdgeInsets.only(bottom: 2, right: 2, left: 2),
                  child: Icon(
                    FontAwesomeIcons.solidHeart,
                    size: 12,
                    color: ThemeColors.favColor[galleryItem.favcat],
                  ),
                )
              : Container(),
        );
      },
    );
  }
}

class TagItem extends StatelessWidget {
  const TagItem({
    Key? key,
    this.text,
    this.color,
    this.backgrondColor,
  }) : super(key: key);

  final String? text;
  final Color? color;
  final Color? backgrondColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        // height: 18,
        padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
        color: backgrondColor ??
            CupertinoDynamicColor.resolve(ThemeColors.tagBackground, context),
        child: Text(
          text ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            height: 1,
            fontWeight:
                backgrondColor == null ? FontWeight.w400 : FontWeight.w500,
            color: color ??
                CupertinoDynamicColor.resolve(ThemeColors.tagText, context),
          ),
          strutStyle: const StrutStyle(height: 1),
        ),
      ),
    );
  }
}

/// 传入原始标签和翻译标签
/// 用于设置切换的时候变更
class TagBox extends StatelessWidget {
  TagBox({Key? key, this.simpleTags}) : super(key: key);

  final List<SimpleTag>? simpleTags;
  final isTagTranslat = false.obs;

  @override
  Widget build(BuildContext context) {
    return simpleTags != null && simpleTags!.isNotEmpty
        ? Obx(() => Container(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
              child: Wrap(
                spacing: 4, //主轴上子控件的间距
                runSpacing: 4, //交叉轴上子控件之间的间距
                children:
                    List<Widget>.from(simpleTags!.map((SimpleTag _simpleTag) {
                  final String? _text = isTagTranslat.value
                      ? _simpleTag.translat
                      : _simpleTag.text;
                  return TagItem(
                    text: _text,
                    color: ColorsUtil.getTagColor(_simpleTag.color),
                    backgrondColor:
                        ColorsUtil.getTagColor(_simpleTag.backgrondColor),
                  );
                }).toList()), //要显示的子控件集合
              ),
            ))
        : Container();
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key, required this.item}) : super(key: key);
  final GalleryItem item;

  @override
  Widget build(BuildContext context) {
    return Text(
      item.englishTitle ?? item.japaneseTitle ?? '',
      maxLines: 4,
      textAlign: TextAlign.left, // 对齐方式
      overflow: TextOverflow.ellipsis, // 超出部分省略号
      style: const TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
        // color: CupertinoColors.label,
      ),
    );
  }
}

class _CoverImage extends StatelessWidget {
  const _CoverImage({
    Key? key,
    required this.item,
    this.tabTag,
    this.cardType = false,
  }) : super(key: key);

  final GalleryItem item;
  final dynamic tabTag;
  final bool cardType;

  final bool isLayoutLarge = false;

  @override
  Widget build(BuildContext context) {
    final double coverImageWidth =
        Get.context!.isPhone ? Get.context!.mediaQueryShortestSide / 3 : 120;
    // 获取图片高度 用于占位
    double? _getHeight() {
      if ((item.imgHeight ?? 0) > coverImageWidth) {
        return (item.imgHeight ?? 0) *
            coverImageWidth /
            (item.imgWidth ?? coverImageWidth);
      } else {
        return item.imgHeight;
      }
    }

    Widget image = CoverImg(
      imgUrl: item.imgUrl ?? '',
      width: coverImageWidth,
      height: item.imgWidth != null ? _getHeight() : null,
    );

    if (!cardType) {
      image = Container(
        width: coverImageWidth,
        height: item.imgWidth != null ? _getHeight() : null,
        child: HeroMode(
          enabled: !isLayoutLarge,
          child: Hero(
            tag: '${item.gid}_cover_${tabTag}',
            child: image,
          ),
        ),
      );

      image = Container(
        decoration: BoxDecoration(boxShadow: [
          //阴影
          BoxShadow(
            color: CupertinoDynamicColor.resolve(
                CupertinoColors.systemGrey4, Get.context!),
            blurRadius: 10,
          )
        ]),
        child: ClipRRect(
          // 圆角
          borderRadius: BorderRadius.circular(6),
          child: image,
        ),
      );
    } else {
      image = Container(
        width: coverImageWidth,
        height: item.imgWidth != null ? _getHeight() : null,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            FittedBox(
              fit: BoxFit.cover,
              child: image.blurred(
                blur: 10,
                colorOpacity: 0.5,
                blurColor: CupertinoTheme.of(context)
                    .barBackgroundColor
                    .withOpacity(1),
              ),
            ),
            HeroMode(
              enabled: !isLayoutLarge,
              child: Center(
                child: Hero(
                  tag: '${item.gid}_cover_$tabTag',
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4), child: image),
                ),
              ),
            ),
          ],
        ),
      );

      image = ClipRRect(
        // 圆角
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(kCardRadius),
          bottomLeft: Radius.circular(kCardRadius),
        ),
        child: image,
      );
    }

    return image;
  }
}

/// 封面图片Widget
class CoverImg extends StatelessWidget {
  const CoverImg({Key? key, required this.imgUrl, this.height, this.width})
      : super(key: key);

  final String imgUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _httpHeaders = {
      'Cookie': '',
      'host': Uri.parse(imgUrl).host,
    };
    Widget image() {
      if (imgUrl.isNotEmpty) {
        return CachedNetworkImage(
          placeholder: (_, __) {
            return Container(
              alignment: Alignment.center,
              color: CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGrey5, context),
              child: const CupertinoActivityIndicator(),
            );
          },
          width: width,
          httpHeaders: _httpHeaders,
          imageUrl: imgUrl,
          fit: BoxFit.fitWidth,
        );
      } else {
        return Container();
      }
    }

    var isBlur = true.obs;
    return Obx(() => BlurImage(
          child: image(),
          isBlur: isBlur.value,
        ));
  }
}

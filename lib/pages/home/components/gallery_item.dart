import 'package:cached_network_image/cached_network_image.dart';
import 'package:ehviewer/components/blur_image.dart';
import 'package:ehviewer/config/theme/theme_colors.dart';
import 'package:ehviewer/model/gallery_item.dart';
import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
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

  final GalleryItemWidget galleryItem;
  final dynamic tabTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Stack(
          children: [],
        ),
      ),
    );
  }

  Widget _buildCardItem() {
    return Obx(() => Container(
          decoration: BoxDecoration(
              color: EhDynamicColors.itemBackground.darkColor,
              borderRadius: BorderRadius.circular(kCardRadius)),
          padding: const EdgeInsets.only(right: kPaddingHorizontal),
          margin: const EdgeInsets.fromLTRB(10, 8, 10, 12),
          child: IntrinsicHeight(
            child: Row(
              children: [],
            ),
          ),
        ));
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

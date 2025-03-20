import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:konesp/config/constant.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/oss_util.dart';

class LoadImage extends StatefulWidget {
  const LoadImage(
    this.ossKey, {
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.border,
    this.color,
    this.holderImg,
    this.holderImgFit = BoxFit.cover,
    this.holderFilePath,
    this.holderImgFormat = ImageFormat.png,
  });

  final String? ossKey;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? color;
  final String? holderImg;
  final BoxFit holderImgFit;
  final String? holderFilePath;
  final ImageFormat holderImgFormat;

  @override
  State<LoadImage> createState() => _LoadImageState();
}

class _LoadImageState extends State<LoadImage> {
  String? _url;

  @override
  Widget build(BuildContext context) {
    if (ObjectUtil.isNotEmpty(_url) && _url!.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: _url!,
        width: widget.width,
        height: widget.height,
        color: widget.color,
        cacheManager: ObjectUtil.isNotEmpty(_url)
            ? CacheManager(
                Config(
                  widget.ossKey!,
                  stalePeriod: Duration(seconds: 7200),
                ),
              )
            : null,
        fadeInDuration: const Duration(milliseconds: 100),
        fadeOutDuration: const Duration(milliseconds: 100),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            border: widget.border,
            image: DecorationImage(
              image: imageProvider,
              fit: widget.fit,
            ),
          ),
        ),
        placeholder: (context, url) => buildPlaceHolder(),
      );
    } else {
      return buildPlaceHolder();
    }
  }

  Widget buildPlaceHolder() {
    if (ObjectUtil.isNotEmpty(widget.holderFilePath)) {
      return LoadFileImage(
        widget.holderFilePath!,
        width: widget.width,
        height: widget.height,
        fit: widget.holderImgFit,
      );
    } else if (ObjectUtil.isNotEmpty(widget.holderImg) && [ImageFormat.jpg, ImageFormat.png].contains(widget.holderImgFormat)) {
      return Image.asset(
        ImageResourceUtil.getImgPath(widget.holderImg!, format: widget.holderImgFormat),
        width: widget.width,
        height: widget.height,
        fit: widget.holderImgFit,
      );
    } else {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: Colours.text_ccc.withOpacity(0.3),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getUrl();
  }

  void _getUrl() async {
    if (ObjectUtil.isEmpty(widget.ossKey)) {
      return;
    }
    String? _signedUrl;
    final _privateOssBox = await Hive.openBox(Constant.privateOssBox);
    final _cacheUrlValue = _privateOssBox.get(widget.ossKey, defaultValue: '');
    if (ObjectUtil.isNotEmpty(_cacheUrlValue)) {
      var uri = Uri.parse(_cacheUrlValue);
      Map<String, String> _query = uri.queryParameters;
      int _expiredMilliseconds = int.parse(_query['Expires']!) * 1000;
      if (_expiredMilliseconds > DateTime.now().millisecondsSinceEpoch) {
        _signedUrl = _cacheUrlValue;
      } else {
        final result = await OssUtil().download(widget.ossKey!);
        if (result.success) {
          final _privateOssBox = await Hive.openBox(Constant.privateOssBox);
          _privateOssBox.put(widget.ossKey, result.data!);
          _signedUrl = result.data!;
        }
      }
    } else {
      final result = await OssUtil().download(widget.ossKey!);
      if (result.success) {
        final _privateOssBox = await Hive.openBox(Constant.privateOssBox);
        _privateOssBox.put(widget.ossKey, result.data!);
        _signedUrl = result.data!;
      }
    }
    if (_url != _signedUrl) {
      setState(() {
        _url = _signedUrl;
      });
    }
  }

  @override
  void didUpdateWidget(covariant LoadImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_url == null || _url! != widget.ossKey) {
      _getUrl();
    }
  }
}

///加载本地svg图片
class LoadSvgImage extends StatelessWidget {
  const LoadSvgImage(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.color,
    this.fit,
  }) : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ImageResourceUtil.getImgPath(image, format: ImageFormat.svg),
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      color: color,
    );
  }
}

/// 加载本地(png,jpg)图片
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit,
    this.format = ImageFormat.png,
    this.color,
  }) : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final ImageFormat format;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageResourceUtil.getImgPath(image, format: format),
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }
}

/// 加载文件图片
class LoadFileImage extends StatelessWidget {
  const LoadFileImage(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit,
    this.color,
  }) : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(image),
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }
}

class ImageResourceUtil {
  static String getImgPath(String name, {ImageFormat format = ImageFormat.png}) {
    return 'assets/image/$name.${format.value}';
  }
}

enum ImageFormat { png, jpg, svg }

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'svg'][index];
}

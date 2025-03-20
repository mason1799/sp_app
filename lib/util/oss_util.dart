import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_oss_aliyun/flutter_oss_aliyun.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/oss_token_entity.dart';
import 'package:konesp/entity/upload_file_entity.dart';
import 'package:konesp/http/base_entity.dart';
import 'package:konesp/http/http.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/watermark_util.dart';
import 'package:konesp/widget/enum_data.dart';

/// aliyun oss
class OssUtil {
  factory OssUtil() => _singleton;

  OssUtil._();

  static final OssUtil _singleton = OssUtil._();

  static OssUtil get instance => OssUtil();

  Future<BaseEntity<UploadFileEntity>> upload(
    String path, {
    required String dict,
    TimeTagFormat timeTag = TimeTagFormat.none,
    bool isDecorateMark = false,
  }) async {
    bool _tokenResult = await queryOssToken();
    if (!_tokenResult) {
      return BaseEntity(10002, 'oss令牌获取失败', null);
    }
    final _ossTokenEntity = StoreLogic.to.ossToken.value!;
    var endpoint = _ossTokenEntity.endpoint;
    if (endpoint?.startsWith('http') == true) {
      endpoint = endpoint!.substring(8);
    }
    Client.init(
      ossEndpoint: endpoint!,
      bucketName: _ossTokenEntity.bucketName!,
      authGetter: () => Auth(
          accessKey: _ossTokenEntity.accessKeyId!,
          accessSecret: _ossTokenEntity.accessKeySecret!,
          secureToken: _ossTokenEntity.securityToken!,
          expire: _ossTokenEntity.expiration!),
    );

    final _file = File(path);
    int _bytes = await _file.length();
    int _quality = switch (_bytes) {
      > 10 * 1024 * 1024 => -1,
      >= 5 * 1024 * 1024 => 70,
      >= 2 * 1024 * 1024 => 80,
      _ => 95,
    };
    if (_quality <= 0) {
      return BaseEntity(10003, '图片超过10M限制，不支持上传', null);
    }
    Uint8List _data = await FlutterImageCompress.compressWithList(await _file.readAsBytes(), quality: _quality);
    if (isDecorateMark) {
      _data = await WatermarkUtil.decorateMark(_data, timeTag: timeTag);
    }
    String _ossKey = '$dict/${DateUtil.getNowDateMs()}.png';
    try {
      await Client().putObject(_data, _ossKey);
      return BaseEntity(
          20000,
          'success',
          UploadFileEntity()
            ..ossKey = _ossKey
            ..path = path);
    } catch (e) {
      return BaseEntity(10004, e.toString(), null);
    }
  }

  Future<BaseEntity<String>> uploadByteData(
    ByteData byteData, {
    required String dict,
  }) async {
    bool _tokenResult = await queryOssToken();
    if (!_tokenResult) {
      return BaseEntity(10002, 'oss令牌获取失败', null);
    }
    final _ossTokenEntity = StoreLogic.to.ossToken.value!;
    var endpoint = _ossTokenEntity.endpoint;
    if (endpoint?.startsWith('http') == true) {
      endpoint = endpoint!.substring(8);
    }
    Client.init(
      ossEndpoint: endpoint!,
      bucketName: _ossTokenEntity.bucketName!,
      authGetter: () => Auth(
          accessKey: _ossTokenEntity.accessKeyId!,
          accessSecret: _ossTokenEntity.accessKeySecret!,
          secureToken: _ossTokenEntity.securityToken!,
          expire: _ossTokenEntity.expiration!),
    );
    final _data = await FlutterImageCompress.compressWithList(byteData.buffer.asUint8List());
    String _ossKey = '$dict/${DateUtil.getNowDateMs()}.png';
    try {
      await Client().putObject(_data, _ossKey);
      return BaseEntity(20000, 'success', _ossKey);
    } catch (e) {
      return BaseEntity(10004, e.toString(), null);
    }
  }

  Future<BaseEntity<String>> download(String ossKeyUrl, {int expireSeconds = 7200}) async {
    bool _tokenResult = await queryOssToken();
    if (!_tokenResult) {
      return BaseEntity(10002, 'oss令牌获取失败', null);
    }
    final _ossTokenEntity = StoreLogic.to.ossToken.value!;
    var endpoint = _ossTokenEntity.endpoint;
    if (endpoint?.startsWith('http') == true) {
      endpoint = endpoint!.substring(8);
    }
    Client.init(
      ossEndpoint: endpoint!,
      bucketName: _ossTokenEntity.bucketName!,
      authGetter: () => Auth(
          accessKey: _ossTokenEntity.accessKeyId!,
          accessSecret: _ossTokenEntity.accessKeySecret!,
          secureToken: _ossTokenEntity.securityToken!,
          expire: _ossTokenEntity.expiration!),
    );
    String _signedUrl = await Client().getSignedUrl(
      ossKeyUrl,
      expireSeconds: expireSeconds,
      bucketName: _ossTokenEntity.bucketName!,
    );
    return BaseEntity(20000, 'success', _signedUrl);
  }

  Future<bool> queryOssToken() async {
    if (StoreLogic.to.ossToken.value != null && (DateUtil.getNowDateMs() < DateUtil.getDateMsByTimeStr(StoreLogic.to.ossToken.value!.expiration!)!)) {
      return true;
    } else {
      final result = await Http().get<OssTokenEntity>(Api.aliyunOssToken);
      if (result.success) {
        StoreLogic.to.ossToken.value = result.data!;
        return true;
      } else {
        return false;
      }
    }
  }
}

///以下处理水印代码比目前在用的更耗时，暂时不采用!(虽然整体效果很好，就是有点耗时)
/*  Future<Uint8List> decorateMark(Uint8List bytes, {TimeTagFormat timeTag = TimeTagFormat.checkIn}) async {
    final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final ui.ImageDescriptor descriptor = await ui.ImageDescriptor.encoded(buffer);
    var width = descriptor.width;
    var height = descriptor.height;
    // 如果图片的宽度或者高度超出了目标尺寸，按比例缩放
    if (width > 1920 || height > 1080) {
      double rate;
      if (width > height) {
        rate = 1920 / width;
        width = 1920;
        height = (height * rate).toInt();
      } else {
        rate = 1080 / height;
        height = 1080;
        width = (width * rate).toInt();
      }
    }
    final waterResult = await _drawMark(bytes, timeTag: timeTag);
    return waterResult;
  }

  Future<Uint8List> _drawMark(Uint8List imageData, {
    TimeTagFormat timeTag = TimeTagFormat.checkIn,
  }) async {
    // 解码图片数据为 ui.Image
    final ui.Codec codec = await ui.instantiateImageCodec(imageData);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image originalImage = frameInfo.image;

    // 获取原始图片的宽高
    final double width = originalImage.width.toDouble();
    final double height = originalImage.height.toDouble();

    // 动态调整大小参数
    final double iconSize = width * 0.04; // 图标大小占图片宽度的 4%
    final double textSize = width * 0.032; // 文字大小占图片宽度的 3.2%
    final double padding = width * 0.01; // 距离图片边缘的内边距
    final double lineSpacing = width * 0.005; // 行间距
    final double maxTextWidth = width * 0.85; // 文字的最大宽度为图片宽度的 85%

    // 配置文字样式
    final TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: textSize,
      shadows: [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1))],
    );

    // 定义图标与文字
    final List<Map<String, dynamic>> overlays = [
      {'icon': Icons.access_time_outlined, 'text': '${timeTag.value}时间：${DateUtil.formatDate(DateTime.now(), format: DateFormats.ymdhm)}'},
      {'icon': Icons.person_outline_rounded, 'text': StoreLogic.to.getUser()!.username},
      {'icon': Icons.location_on_outlined, 'text': StoreLogic.to.address.value ?? '无'},
    ];

    // 创建一个新的 Canvas
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromPoints(Offset(0, 0), Offset(width, height)));

    // 绘制原始图片
    final paint = Paint();
    canvas.drawImage(originalImage, Offset(0, 0), paint);

    // 预计算文字和图标的绘制
    final List<TextPainter> textPainters = [];
    final List<Offset> iconOffsets = [];

    for (int i = 0; i < overlays.length; i++) {
      final icon = overlays[i]['icon'] as IconData;
      final text = overlays[i]['text'] as String;

      // 计算每个图标和文本的位置
      final double yOffset = height - padding - (overlays.length - i) * (iconSize + lineSpacing);

      // 计算图标和文字绘制的文本
      final textPainterIcon = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            fontFamily: icon.fontFamily,
            fontSize: iconSize,
            color: Colors.white,
            shadows: [Shadow(blurRadius: 2, color: Colors.black, offset: Offset(1, 1))],
          ),
        ),
      );
      textPainterIcon.layout();
      textPainters.add(textPainterIcon);

      final textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
        text: TextSpan(
          text: text,
          style: textStyle,
        ),
      );
      textPainter.layout(minWidth: 0, maxWidth: maxTextWidth);
      textPainters.add(textPainter);

      // 记录图标和文本的偏移位置
      iconOffsets.add(Offset(padding, yOffset));
    }

    // 绘制所有图标和文字（避免多次调用 layout 和 paint）
    for (int i = 0; i < overlays.length; i++) {
      // 绘制图标
      textPainters[i * 2].paint(canvas, iconOffsets[i]);

      // 绘制文字
      final double textOffsetY = iconOffsets[i].dy + (iconSize - textPainters[i * 2 + 1].height) / 2;
      textPainters[i * 2 + 1].paint(canvas, Offset(iconOffsets[i].dx + iconSize + padding, textOffsetY));
    }

    // 结束绘制并转换为图片
    final ui.Picture picture = recorder.endRecording();
    final ui.Image newImage = await picture.toImage(width.toInt(), height.toInt());

    // 将图片编码为 Uint8List
    final ByteData? byteData = await newImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
*/

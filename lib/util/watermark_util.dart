import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/enum_data.dart';

class WatermarkUtil {
  static Future<Uint8List> decorateMark(Uint8List bytes, {TimeTagFormat timeTag = TimeTagFormat.checkIn}) async {
    final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final ui.ImageDescriptor descriptor = await ui.ImageDescriptor.encoded(buffer);
    var width = descriptor.width;
    var height = descriptor.height;
    if (width > height) {
      final rate = 1920 * 1.0 / descriptor.width;
      width = 1920;
      height = (descriptor.height * rate).toInt();
    } else {
      final rate = 1080 * 1.0 / descriptor.height;
      height = 1080;
      width = (descriptor.width * rate).toInt();
    }
    final waterResult = await drawMark(bytes, width, height, timeTag);
    return waterResult;
  }

  static Future<Uint8List> drawMark(Uint8List list, int targetWidth, int targetHeight, TimeTagFormat timeTag) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final ui.Canvas canvas = ui.Canvas(recorder);
    final ui.Codec codec = await ui.instantiateImageCodec(list, targetWidth: targetWidth, targetHeight: targetHeight);
    final ui.FrameInfo frame = await codec.getNextFrame();
    final ui.Image image = frame.image;
    final paint = ui.Paint();
    canvas.drawImage(image, ui.Offset.zero, paint);

    final time = DateTime.now();
    final style = ui.ParagraphStyle(
      textAlign: ui.TextAlign.start,
      ellipsis: '...',
      fontWeight: ui.FontWeight.normal,
      fontStyle: ui.FontStyle.normal,
    );

    // Text shadow
    final shadow = ui.Shadow(
      color: Colors.black.withOpacity(0.5), // Shadow color
      offset: Offset(1.5, 1.5), // Shadow offset
      blurRadius: 2, // Shadow blur radius
    );

    final bgPaint = ui.Paint();
    bgPaint.color = Colors.transparent;

    final ui.ParagraphBuilder pb1 = ui.ParagraphBuilder(style)
      ..pushStyle(ui.TextStyle(color: Colors.white, fontSize: 24, background: bgPaint, shadows: [shadow]))
      ..addText('${timeTag.value}时间 : ${DateUtil.formatDate(time, format: DateFormats.hm)}');

    final ui.ParagraphBuilder pb2 = ui.ParagraphBuilder(style)
      ..pushStyle(ui.TextStyle(color: Colors.white, fontSize: 24, background: bgPaint, shadows: [shadow]))
      ..addText('${DateUtil.formatDate(time, format: DateFormats.slashYmd)} ${DateUtil.getWeekday(time)}');

    final ui.ParagraphBuilder pb3 = ui.ParagraphBuilder(style)
      ..pushStyle(ui.TextStyle(color: Colors.white, fontSize: 24, background: bgPaint, shadows: [shadow]))
      ..addText(ObjectUtil.isNotEmpty(StoreLogic.to.address.value) ? StoreLogic.to.address.value! : '无');

    final ui.ParagraphBuilder pb4 = ui.ParagraphBuilder(style)
      ..pushStyle(ui.TextStyle(color: Colors.white, fontSize: 24, background: bgPaint, shadows: [shadow]))
      ..addText('${StoreLogic.to.getUser()?.username}');

    final ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: image.width.toDouble() - 70);
    final ui.Paragraph paragraph1 = pb1.build()..layout(pc);
    final ui.Paragraph paragraph2 = pb2.build()..layout(pc);
    final ui.Paragraph paragraph3 = pb3.build()..layout(pc);
    final ui.Paragraph paragraph4 = pb4.build()..layout(pc);

    canvas.drawParagraph(
        paragraph1, Offset(70, image.height.toDouble() - paragraph1.height - paragraph2.height - paragraph3.height - paragraph4.height - 20));
    canvas.drawParagraph(paragraph2, Offset(70, image.height.toDouble() - paragraph2.height - paragraph3.height - paragraph4.height - 20));
    canvas.drawParagraph(paragraph4, Offset(70, image.height.toDouble() - paragraph4.height - paragraph3.height - 20));

    final pa = ui.Paint();

    final iconSize = 24.0;
    final timeIcon = await _getIconAsImage(Icons.access_time_outlined, iconSize);
    final avatarIcon = await _getIconAsImage(Icons.person_outline_rounded, iconSize);
    final locationIcon = await _getIconAsImage(Icons.location_on_outlined, iconSize);

    canvas.drawImage(
      timeIcon,
      Offset(30, image.height.toDouble() - paragraph1.height - paragraph2.height - paragraph3.height - paragraph4.height - 20),
      pa,
    );
    canvas.drawImage(
      avatarIcon,
      Offset(30, image.height.toDouble() - paragraph4.height - paragraph3.height - 18),
      pa,
    );
    canvas.drawImage(
      locationIcon,
      Offset(30, image.height.toDouble() - paragraph3.height - 20),
      pa,
    );

    canvas.drawParagraph(paragraph3, Offset(70, image.height.toDouble() - paragraph3.height - 20));

    final ui.Picture picture = recorder.endRecording();
    final img = await picture.toImage(image.width, image.height);
    final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
    return bytes!.buffer.asUint8List();
  }

// Helper function to convert an icon to an image
  static Future<ui.Image> _getIconAsImage(IconData iconData, double size) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = ui.Canvas(pictureRecorder);
    final textPainter = TextPainter(
      text: TextSpan(text: String.fromCharCode(iconData.codePoint), style: TextStyle(fontFamily: iconData.fontFamily, fontSize: size)),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(0, 0));
    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    return img;
  }
}

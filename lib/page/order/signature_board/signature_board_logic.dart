import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/page/dashboard/customer_signature/fix/fix_list_logic.dart';
import 'package:konesp/routes/app_routes.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/oss_util.dart';

import '../comment/comment_logic.dart';
import '../fix_detail/fix_detail_logic.dart';
import '../regular_detail/regular_detail_logic.dart';
import 'signature_board_state.dart';

class SignatureBoardLogic extends BaseController {
  final SignatureBoardState state = SignatureBoardState();

  void onDrawEnd() {
    state.hasSign = true;
  }

  void clear() {
    state.signaturePadKey.currentState?.clear();
    state.hasSign = false;
  }

  void confirm() async {
    if (!state.hasSign) {
      showToast('请添加签字');
      return;
    }
    showProgress();
    final image = await state.signaturePadKey.currentState!.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      showToast('签字获取失败');
    }
    ByteData? rotatedByteData = await _rotateImage(byteData!, image.width, image.height);
    if (rotatedByteData == null) {
      showToast('签字获取失败');
      return;
    }
    final result = await OssUtil().uploadByteData(
      rotatedByteData,
      dict: 'sign',
    );
    closeProgress();
    if (result.success) {
      if (state.type == 1) {
        if (Get.isRegistered<RegularDetailLogic>()) {
          Get.until((route) => route.settings.name == Routes.regularDetail);
          Map map = {};
          map[state.employeeCode] = result.data!;
          Get.find<RegularDetailLogic>().commitSign(signImage: jsonEncode(map));
        }
      } else if (state.type == 2) {
        if (Get.isRegistered<FixDetailLogic>()) {
          Get.until((route) => route.settings.name == Routes.fixDetail);
          Get.find<FixDetailLogic>().sign(
            signImage: result.data!,
            userid: state.userId > -1 ? state.userId : StoreLogic.to.getUser()!.id!,
          );
        }
      } else if (state.type == 3) {
        Get.back();
        if (Get.isRegistered<FixListLogic>()) {
          Get.find<FixListLogic>().uploadSign(result.data!);
        }
      } else if (state.type == 4) {
        Get.back();
        if (Get.isRegistered<CommentLogic>()) {
          Get.find<CommentLogic>().updateSignature(result.data!);
        }
      }
    } else {
      showToast(result.msg);
    }
  }

  Future<ByteData?> _rotateImage(ByteData bytes, int width, int height) async {
    try {
      // 读取原始字节数据
      final originalImage = await _decodeImageFromList(bytes.buffer.asUint8List());
      // 计算旋转后的宽高
      final rotatedWidth = originalImage.height; // 旋转后宽度是原始高度
      final rotatedHeight = originalImage.width; // 旋转后高度是原始宽度

      // 创建一个新的画布，使用旋转后图像的尺寸
      final recorder = ui.PictureRecorder();
      final canvas = ui.Canvas(
          recorder,
          Rect.fromPoints(Offset(0, 0), Offset(rotatedWidth.toDouble(), rotatedHeight.toDouble()))
      );

      // 将画布中心移到旋转点
      canvas.translate(rotatedWidth / 2, rotatedHeight / 2);
      // 逆时针旋转90度（-π/2弧度）
      canvas.rotate(-3.14159 / 2);
      // 移动回图像原始位置
      canvas.translate(-originalImage.width / 2, -originalImage.height / 2);

      // 绘制原图像
      canvas.drawImage(originalImage, Offset(0, 0), ui.Paint());

      // 记录并渲染旋转后的图像
      final picture = recorder.endRecording();
      final img = await picture.toImage(rotatedWidth, rotatedHeight);
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      return byteData;
    } catch (e) {
      print('旋转图像时出错: $e');
      return null;
    }
  }


  Future<ui.Image> _decodeImageFromList(Uint8List list) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(list, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}

import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/upload_file_entity.dart';
import 'package:konesp/mvp/base_controller.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/util/oss_util.dart';
import 'package:konesp/widget/enum_data.dart';

import '../fix_detail/fix_detail_logic.dart';
import '../regular_detail/regular_detail_logic.dart';
import 'remark_state.dart';

class RemarkLogic extends BaseController {
  final RemarkState state = RemarkState();

  @override
  void onInit() {
    state.imageList = convertStrList(state.imagePic);
    state.textController.text = state.content ?? '';
    super.onInit();
  }

  void toSave() async {
    int _index = state.imageList.indexWhere(
      (element) => (ObjectUtil.isEmpty(element.ossKey) && ObjectUtil.isNotEmpty(element.path)),
    );
    if (_index > -1) {
      showToast('请等待照片上传');
      return;
    }
    String _remarkText = state.textController.text;
    String _remarkImages = state.imageList.map((e) => e.ossKey).toList().join(',');
    showProgress();
    final result = await post(state.type == 0 ? Api.saveRegularOrderRemarks : Api.saveFixOrderRemarks,
        params: state.type == 0
            ? {
                'id': state.id,
                'remark': _remarkText,
                'orderImage': _remarkImages,
              }
            : {
                'id': state.id,
                'remark': _remarkText,
                'remarkImages': _remarkImages,
              });
    closeProgress();
    if (result.success) {
      Get.back();
      if (state.type == 0) {
        if (Get.isRegistered<RegularDetailLogic>()) {
          Get.find<RegularDetailLogic>().query();
        }
      } else {
        if (Get.isRegistered<FixDetailLogic>()) {
          Get.find<FixDetailLogic>().setRemarkData(_remarkText, state.imageList.map((e) => e.ossKey ?? '').toList());
        }
      }
    } else {
      showToast(result.msg);
    }
  }

  List<UploadFileEntity> convertStrList(String? pic) {
    if (ObjectUtil.isNotEmpty(pic)) {
      try {
        List array = pic!.split(',');
        List<UploadFileEntity> list = [];
        for (var item in array) {
          list.add(UploadFileEntity()..ossKey = item);
        }
        return list;
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  void onAddItems(List<String> newItems) async {
    var list = newItems.map((item) => UploadFileEntity()..path = item).toList();
    state.imageList.addAll(list);
    update(['images']);
    for (int i = 0; i < state.imageList.length; i++) {
      UploadFileEntity uploadFile = state.imageList[i];
      if (ObjectUtil.isEmpty(uploadFile.ossKey) && ObjectUtil.isNotEmpty(uploadFile.path)) {
        final uploadResult = await OssUtil.instance.upload(
          uploadFile.path!,
          timeTag: TimeTagFormat.remark,
          dict: 'detail',
          isDecorateMark: true,
        );
        if (uploadResult.success) {
          state.imageList[i] = uploadResult.data!;
          update(['images']);
        }
      }
    }
  }

  void onDeleteItems(List<UploadFileEntity> newItems) {
    state.imageList = newItems;
    update(['images']);
  }
}

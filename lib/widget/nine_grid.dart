import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:konesp/entity/upload_file_entity.dart';
import 'package:konesp/util/file_util.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/sheet/alert_bottom_sheet.dart';
import 'package:konesp/widget/sheet/confirm_dialog.dart';
import 'package:konesp/widget/upload_image.dart';

class NineGrid extends StatelessWidget {
  NineGrid(
    this.images, {
    this.enableEdit = false,
    required this.onAdd,
    required this.onDelete,
    Key? key,
  }) : super(key: key);
  final List<UploadFileEntity> images;
  final Function(List<String>) onAdd;
  final Function(List<UploadFileEntity>) onDelete;
  final bool enableEdit;
  final int maxCount = 3;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.w,
        childAspectRatio: 1,
      ),
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index < images.length) {
          return UploadImage(
            images[index],
            enableEdit: enableEdit,
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.zero,
            fit: BoxFit.cover,
            delCallback: (delFile) {
              Get.dialog(
                ConfirmDialog(
                  content: '确认删除该图片吗？',
                  onConfirm: () {
                    images.removeAt(index);
                    List<UploadFileEntity> _temps = List.from(images);
                    onDelete(_temps);
                  },
                ),
              );
            },
          );
        }
        return GestureDetector(
          onTap: () {
            showAlertBottomSheet(['拍照', '从相册中选择'], (data, index) async {
              if (index == 0) {
                final _photo = await FileUtil.takeCamera();
                if (_photo == null) {
                  return;
                }
                onAdd([_photo]);
              } else if (index == 1) {
                final _photos = await FileUtil.takePhotos(limitCount: maxCount - images.length);
                if (_photos.isEmpty) {
                  return;
                }
                onAdd(_photos);
              }
            });
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Color(0xFFEEF5FF),
            ),
            alignment: Alignment.center,
            child: LoadAssetImage(
              'icon_plus',
              width: 20.w,
              height: 20.w,
            ),
          ),
        );
      },
      itemCount: images.length +
          (enableEdit
              ? images.length < maxCount
                  ? 1
                  : 0
              : 0),
    );
  }
}

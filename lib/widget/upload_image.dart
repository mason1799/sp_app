import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/entity/upload_file_entity.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/photo_preview.dart';

class UploadImage extends StatelessWidget {
  final Function(UploadFileEntity f)? delCallback;
  final UploadFileEntity file;
  final bool enableEdit;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final BoxFit fit;

  UploadImage(
    this.file, {
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.margin,
    this.enableEdit = true,
    this.delCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 80.w,
      height: height ?? 80.w,
      margin: margin ?? EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        color: Color(0xFFEDEFF0),
        borderRadius: BorderRadius.all(
          Radius.circular(4.w),
        ),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () => Get.to(() => PhotoPreview(ossKey: file.ossKey, path: file.path)),
                  child: LoadImage(
                    file.ossKey,
                    width: width ?? 80.w,
                    height: height ?? 80.w,
                    fit: fit,
                    holderFilePath: file.path,
                  ),
                ),
              ),
              if (enableEdit && ObjectUtil.isEmpty(file.ossKey))
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.w, bottom: 5.w),
                    child: SizedBox(
                      width: 10.w,
                      height: 10.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.w,
                        valueColor: AlwaysStoppedAnimation<Color>(Colours.primary),
                      ),
                    ),
                  ),
                )
              else if (enableEdit)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Icon(
                      Icons.check_rounded,
                      size: 12.w,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (enableEdit)
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => delCallback?.call(file),
                    child: Container(
                      padding: EdgeInsets.only(left: 5.w, bottom: 5.w),
                      color: Colors.transparent,
                      child: LoadAssetImage(
                        'delete_icon',
                        width: 15.w,
                        height: 15.w,
                      ),
                    ),
                  ),
                ),
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:konesp/widget/load_image.dart';

class EquipmentIcon extends StatelessWidget {
  const EquipmentIcon({this.type});

  final int? type;

  @override
  Widget build(BuildContext context) {
    if (type == 1) {
      // 牵引客梯
      return LoadSvgImage(
        'elevator',
        width: 30.w,
      );
    } else if (type == 2) {
      // 扶梯
      return LoadSvgImage(
        'escalator',
        width: 30.w,
      );
    } else {
      // 其他电梯（货梯/消防防爆/等等）
      return LoadSvgImage(
        'lift',
        width: 30.w,
      );
    }
  }
}

class CommonUtil {
  static String hidePhone(String phone) {
    if (phone.length != 11) {
      return phone;
    }
    return '${phone.substring(0, 3)}****${phone.substring(7)}';
  }

  // 格式化距离, 超过1公里小数点后保留两位
  static String formatDistance(double? meters) {
    return '${meters?.toStringAsFixed(0) ?? 0}米';
    /*if (meters == null || meters < 1000) {
      return '${meters?.toStringAsFixed(0) ?? 0}米';
    } else {
      double kilometers = meters / 1000;
      return '${kilometers.toStringAsFixed(2)}公里';
    }*/
  }
}

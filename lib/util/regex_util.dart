class RegexUtil {
  /// 校验手机号码格式
  static bool isMobile(String? input) {
    if (input == null || input.isEmpty) return false;
    RegExp exp = RegExp(r'^(1\d{10})$');
    return exp.hasMatch(input);
  }

  /// 校验密码格式
  static bool isPassword(String? input) {
    if (input == null || input.isEmpty) return false;
    RegExp exp = RegExp(r'^(?=.*\d)(?=.*[a-zA-Z])(?=.*[^\da-zA-Z\s]).{8,16}$');
    return exp.hasMatch(input);
  }

  /// 校验邮箱格式
  static bool isEmail(String? input) {
    if (input == null || input.isEmpty) return false;
    String regexEmail = '^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$';
    return RegExp(regexEmail).hasMatch(input);
  }
}

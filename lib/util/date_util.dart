/// 一些常用格式参照。可以自定义格式，例如：'yyyy/MM/dd HH:mm:ss'，'yyyy/M/d HH:mm:ss'。
/// 格式要求
/// year -> yyyy/yy   month -> MM/M    day -> dd/d
/// hour -> HH/H      minute -> mm/m   second -> ss/s
class DateFormats {
  static String full = 'yyyy-MM-dd HH:mm:ss';
  static String ymdhm = 'yyyy-MM-dd HH:mm';
  static String ymd = 'yyyy-MM-dd';
  static String ym = 'yyyy-MM';
  static String md = 'MM-dd';
  static String mdhm = 'MM-dd HH:mm';
  static String hms = 'HH:mm:ss';
  static String hm = 'HH:mm';
  static String slashYmd = 'yyyy/MM/dd';

  static String zhFull = 'yyyy年MM月dd日 HH时mm分ss秒';
  static String zhYmdhm = 'yyyy年MM月dd日 HH时mm分';
  static String zhYmd = 'yyyy年MM月dd日';
  static String zhYm = 'yyyy年MM月';
  static String zhMd = 'MM月dd日';
  static String zhMdhm = 'MM月dd日 HH时mm分';
  static String zhHms = 'HH时mm分ss秒';
  static String zhHm = 'HH时mm分';
}

/// month->days.
Map<int, int> daysOfMonth = {
  1: 31,
  2: 28,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31,
};

class DateUtil {

  /// get Timestamp By DateTime.
  static int getYmdTimestamp(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day).millisecondsSinceEpoch;
  }

  /// get DateTime By DateStr.
  static DateTime? getDateTime(String? dateStr, {bool? isUtc}) {
    if (dateStr == null) {
      return null;
    }
    DateTime? dateTime = DateTime.tryParse(dateStr);
    if (isUtc != null) {
      if (isUtc) {
        dateTime = dateTime?.toUtc();
      } else {
        dateTime = dateTime?.toLocal();
      }
    }
    return dateTime;
  }

  /// get DateTime By Milliseconds.
  static DateTime getDateTimeByMs(int ms, {bool isUtc = false}) {
    return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
  }

  /// get DateMilliseconds By DateStr.
  static int? getDateMsByTimeStr(String dateStr, {bool? isUtc}) {
    DateTime? dateTime = getDateTime(dateStr, isUtc: isUtc);
    return dateTime?.millisecondsSinceEpoch;
  }

  /// get Now Date Milliseconds.
  static int getNowDateMs() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// get Now Date Str.(yyyy-MM-dd HH:mm:ss)
  static String getNowDateStr() {
    return formatDate(DateTime.now());
  }

  /// format date by milliseconds.
  /// milliseconds 日期毫秒
  static String formatDateMs(int ms, {bool isUtc = false, String? format}) {
    return formatDate(getDateTimeByMs(ms, isUtc: isUtc), format: format);
  }

  /// format date by date str.
  /// dateStr 日期字符串
  static String? formatDateStr(String? dateStr, {bool? isUtc, String? format}) {
    if (dateStr == null) {
      return null;
    }
    return formatDate(getDateTime(dateStr, isUtc: isUtc), format: format);
  }

  /// format date by DateTime.
  /// format 转换格式(已提供常用格式 DateFormats，可以自定义格式：'yyyy/MM/dd HH:mm:ss')
  /// 格式要求
  /// year -> yyyy/yy   month -> MM/M    day -> dd/d
  /// hour -> HH/H      minute -> mm/m   second -> ss/s
  static String formatDate(DateTime? dateTime, {String? format}) {
    if (dateTime == null) return '';
    format = format ?? DateFormats.full;
    if (format.contains('yy')) {
      String year = dateTime.year.toString();
      if (format.contains('yyyy')) {
        format = format.replaceAll('yyyy', year);
      } else {
        format = format.replaceAll('yy', year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }

  /// com format.
  static String _comFormat(int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format = format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }

  /// get WeekDay.
  /// dateTime
  /// isUtc
  /// languageCode zh or en
  /// short
  static String getWeekday(DateTime? dateTime, {String languageCode = 'zh', bool short = false}) {
    if (dateTime == null) return '';
    String weekday = '';
    switch (dateTime.weekday) {
      case 1:
        weekday = languageCode == 'zh' ? '星期一' : 'Monday';
        break;
      case 2:
        weekday = languageCode == 'zh' ? '星期二' : 'Tuesday';
        break;
      case 3:
        weekday = languageCode == 'zh' ? '星期三' : 'Wednesday';
        break;
      case 4:
        weekday = languageCode == 'zh' ? '星期四' : 'Thursday';
        break;
      case 5:
        weekday = languageCode == 'zh' ? '星期五' : 'Friday';
        break;
      case 6:
        weekday = languageCode == 'zh' ? '星期六' : 'Saturday';
        break;
      case 7:
        weekday = languageCode == 'zh' ? '星期日' : 'Sunday';
        break;
      default:
        break;
    }
    return languageCode == 'zh' ? (short ? weekday.replaceAll('星期', '周') : weekday) : weekday.substring(0, short ? 3 : weekday.length);
  }

  /// get WeekDay By Milliseconds.
  static String getWeekdayByMs(int milliseconds, {bool isUtc = false, String languageCode = 'en', bool short = false}) {
    DateTime dateTime = getDateTimeByMs(milliseconds, isUtc: isUtc);
    return getWeekday(dateTime, languageCode: languageCode, short: short);
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYear(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int days = dateTime.day;
    for (int i = 1; i < month; i++) {
      days = days + daysOfMonth[i]!;
    }
    if (isLeapYearByYear(year) && month > 2) {
      days = days + 1;
    }
    return days;
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYearByMs(int ms, {bool isUtc = false}) {
    return getDayOfYear(DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc));
  }

  /// is today.
  /// 是否是当天.
  static bool isToday(int? milliseconds, {bool isUtc = false, int? locMs}) {
    if (milliseconds == null || milliseconds == 0) return false;
    DateTime old = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    DateTime now;
    if (locMs != null) {
      now = DateUtil.getDateTimeByMs(locMs);
    } else {
      now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    }
    return old.year == now.year && old.month == now.month && old.day == now.day;
  }

  /// is yesterday by dateTime.
  /// 是否是昨天.
  static bool isYesterday(DateTime dateTime, DateTime locDateTime) {
    if (yearIsEqual(dateTime, locDateTime)) {
      int spDay = getDayOfYear(locDateTime) - getDayOfYear(dateTime);
      return spDay == 1;
    } else {
      return ((locDateTime.year - dateTime.year == 1) &&
          dateTime.month == 12 &&
          locDateTime.month == 1 &&
          dateTime.day == 31 &&
          locDateTime.day == 1);
    }
  }

  /// is yesterday by millis.
  /// 是否是昨天.
  static bool isYesterdayByMs(int ms, int locMs) {
    return isYesterday(DateTime.fromMillisecondsSinceEpoch(ms), DateTime.fromMillisecondsSinceEpoch(locMs));
  }

  /// is Week.
  /// 是否是本周.
  static bool isWeek(int? ms, {bool isUtc = false, int? locMs}) {
    if (ms == null || ms <= 0) {
      return false;
    }
    DateTime _old = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
    DateTime _now;
    if (locMs != null) {
      _now = DateUtil.getDateTimeByMs(locMs, isUtc: isUtc);
    } else {
      _now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    }

    DateTime old = _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _old : _now;
    DateTime now = _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _now : _old;
    return (now.weekday >= old.weekday) && (now.millisecondsSinceEpoch - old.millisecondsSinceEpoch <= 7 * 24 * 60 * 60 * 1000);
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqual(DateTime dateTime, DateTime locDateTime) {
    return dateTime.year == locDateTime.year;
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqualByMs(int ms, int locMs) {
    return yearIsEqual(DateTime.fromMillisecondsSinceEpoch(ms), DateTime.fromMillisecondsSinceEpoch(locMs));
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYear(DateTime dateTime) {
    return isLeapYearByYear(dateTime.year);
  }

  /// Return whether it is leap year.
  /// 是否是闰年
  static bool isLeapYearByYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  ///格式化数字
  static String formatNum(num? value, {int digits = 4, bool autoSplitByThousand = false}) {
    if (value == null) {
      return '0';
    }
    String result = '0';

    if (value.isInfinite) {
      result = value.toStringAsFixed(digits);
    } else {
      if (digits == 0) {
        result = value.toStringAsFixed(0);
      }
      var s = value.toString();
      var dotIndex = s.indexOf('.');
      if (dotIndex == -1) {
        // s的结果web platform有差异
        result = s;
      }
      var dotS = s.substring(dotIndex + 1);

      if (dotS.length > digits) {
        var s = value.toStringAsFixed(digits);
        var n = num.tryParse(s);
        if (n == null) {
          result = s;
        } else {
          result = n.truncateToDouble() == n ? n.toStringAsFixed(0) : n.toString();
        }
      } else {
        result = value.truncateToDouble() == value ? value.toStringAsFixed(0) : value.toString();
      }
    }
    return autoSplitByThousand ? _splitByThousand(result) : result;
  }

  ///对数字字符串做千位分割
  static String _splitByThousand(String src) {
    if ((src.isNotEmpty) && num.tryParse(src) != null) {
      int dotIndex = src.indexOf('.');
      String? dotS = dotIndex == -1 ? null : src.substring(dotIndex + 1);
      String dotP = dotIndex == -1 ? src : src.substring(0, dotIndex);
      String result = '';
      int value = num.tryParse(dotP) as int;
      while (value >= 1000) {
        String reminder = '${value % 1000}';
        if (reminder.length == 1) {
          reminder = '00$reminder';
        } else if (reminder.length == 2) {
          reminder = '0$reminder';
        }
        result = '$reminder,$result';
        value = value ~/ 1000;
      }
      if (value > 0) {
        result = '$value,$result';
      } else if (value == 0 && result.isEmpty) {
        result = '0';
      } else {
        result = value.toString();
      }
      if (result.endsWith(',')) {
        dotP = result.substring(0, result.length - 1);
      } else {
        dotP = result;
      }
      return "$dotP${dotIndex == -1 ? "" : ".$dotS"}";
    } else {
      return src;
    }
  }

  static String getTimeRemaining(int currentTimeStamp, int updateTimestamp) {
    Duration difference = Duration(milliseconds: currentTimeStamp - updateTimestamp);
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;
    String result = '';
    if (days > 0) {
      result += '$days天';
    }
    result += '${formatTime(hours)}:${formatTime(minutes)}:${formatTime(seconds)}';
    return result;
  }

  ///数字格式化，将 0~9 的时间转换为 00~09
  static String formatTime(int timeNum) {
    return timeNum < 10 ? '0$timeNum' : timeNum.toString();
  }
}

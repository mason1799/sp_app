import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  // 申请一个权限
  static Future<bool> requestPermission(Permission permission) async {
    var status = await permission.status;
    if (status == PermissionStatus.granted || status == PermissionStatus.limited) {
      return true;
    } else {
      status = await permission.request();
      if (status == PermissionStatus.granted || status == PermissionStatus.limited) {
        return true;
      } else {
        return false;
      }
    }
  }

  // 申请多个权限
  static Future<bool> requestPermissions(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    List<bool> results = statuses.values.toList().map((status) {
      return status == PermissionStatus.granted || status == PermissionStatus.limited;
    }).toList();
    return !results.contains(false);
  }
}

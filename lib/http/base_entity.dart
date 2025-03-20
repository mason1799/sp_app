import 'package:konesp/generated/json/base/json_convert_content.dart';

class BaseEntity<T> {
  int? code;
  late String msg;
  T? data;
  bool hasMore = false;
  int? totalPage;

  BaseEntity(this.code, this.msg, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'] as int?;
    msg = json['msg'] as String;
    data = _generateOBJ<T>(json['data']);
    _handlePagination(json);
  }

  T? _generateOBJ<T>(Object? data) {
    if (data == null) {
      return null;
    } else if (T == String) {
      return data.toString() as T;
    } else if (T == Map) {
      return data as T;
    } else if (T.toString() == 'List<String>' && data is List) {
      return data.map((e) => e.toString()).toList() as T;
    } else {
      return JsonConvert.fromJsonAsT<T>(data);
    }
  }

  void _handlePagination(Map<String, dynamic> json) {
    if (json.containsKey('curPage') && json.containsKey('sizePage') && json.containsKey('totalPage')) {
      final curPage = json['curPage'] as int;
      final sizePage = json['sizePage'] as int;
      totalPage = json['totalPage'] as int;
      hasMore = (curPage * sizePage < totalPage!);
    }
  }

  bool get success => code == 20000;
}

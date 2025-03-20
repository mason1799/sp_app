import 'package:konesp/entity/department_info_entity.dart';

class DepartmentNode {
  String? id;
  String? parentId;
  double? sort;
  String? name;
  DepartmentNode? parent;
  List<DepartmentNode>? children;
  double? directorId;
  String? directorName;
  String? directorPhone;
  double? employeeNumber;
  double? level;

  /// 辅助字段 当前条目选中态
  bool select = false;

  /// 辅助字段  有子children选中  选中样式 局部选中
  bool? hasChildrenCheck;

  /// 辅助字段 所有子children都选中  选中样式 全部选中
  bool? allChildrenCheck;

  DepartmentNode();

  /// DFS 深度优先遍历
  factory DepartmentNode.fromEntity(DepartmentInfoEntity entity) {
    var node = DepartmentNode()
      ..name = entity.name
      ..id = entity.id
      ..parentId = entity.parentId
      ..sort = entity.sort
      ..directorId = entity.directorId
      ..directorName = entity.directorName
      ..directorPhone = entity.directorPhone
      ..employeeNumber = entity.employeeNumber
      ..level = entity.level;
    if (entity.children?.isNotEmpty == true) {
      List<DepartmentNode> children = [];
      int index = 0;
      while (index < entity.children!.length) {
        children.add(DepartmentNode.fromEntity(entity.children![index])..parent = node);
        index++;
      }
      if (children.isNotEmpty) {
        node.children = children;
      }
    }

    return node;
  }

  /// 检查子孙选中态  设置 hasChildrenCheck、allChildrenCheck值
  void runChildrenCheck() {
    hasChildrenCheck = false;
    allChildrenCheck = select;
    if (children?.isNotEmpty != true) {
      hasChildrenCheck = select;
    } else {
      for (var i = 0; i < children!.length; ++i) {
        var department = children![i];
        department.runChildrenCheck();
        if (department.hasChildrenCheck == true) {
          hasChildrenCheck = true;
        }
        if (!department.select) {
          allChildrenCheck = false;
        }
      }
    }
  }

  /// 获取选中的子孙部门列表
  List<DepartmentNode> getSelectChildren() {
    List<DepartmentNode> selectList = [];
    _addSelectChildren(selectList);
    return selectList;
  }

  /// 将选中的子 children添加到列表中
  void _addSelectChildren(List<DepartmentNode> selectList) {
    if (select) {
      selectList.add(this);
      return;
    }
    children?.forEach((department) {
      department._addSelectChildren(selectList);
    });
  }

  /// 获取包含的子孙部门列表
  List<DepartmentNode> getContainsDepartments(String value) {
    List<DepartmentNode> departments = [];
    _getContainsDepartments(value, departments);
    return departments;
  }

  /// 添加包含的子孙部门列表
  void _getContainsDepartments(String value, List<DepartmentNode> departments) {
    if (name?.contains(value) == true) {
      departments.add(this);
    }
    children?.forEach((department) {
      department._getContainsDepartments(value, departments);
    });
  }

  /// 设置为选中，子孙部门也设置成选中
  void check(bool check) {
    select = check;
    updateParentCheck();
    children?.forEach((department) {
      department.check(check);
    });
  }

  /// 更新父级选中态
  void updateParentCheck() {
    if (parent == null) {
      return;
    }
    parent!.select = true;
    for (var element in parent!.children!) {
      if (!element.select) {
        parent?.select = false;
      }
    }
    parent!.updateParentCheck();
  }

  /// 单选  取消同级选中 子部门不设置选中
  void singleCheck(bool check) {
    /// 取消所有选中
    cancelAllSelect();
    select = check;
    singleCheckParent(check);
  }

  void singleCheckParent(bool check) {
    select = check;
    if (parent != null) {
      parent?.children?.forEach((element) {
        if (element.id != id) {
          element.select = false;
        }
      });
      parent!.singleCheckParent(true);
    }
  }

  /// 回显用的初始化 选中态
  void initCheck(List<String> idList) {
    if (idList.contains(id)) {
      check(true);
    } else {
      children?.forEach((department) {
        department.initCheck(idList);
      });
    }
  }

  /// 回显用的初始化 选中态 单选
  void initSingleCheck(String? selectID) {
    if (selectID == id) {
      singleCheck(true);
    } else {
      children?.forEach((department) {
        department.initSingleCheck(selectID);
      });
    }
  }

  /// 取消所有选择
  void cancelAllSelect() {
    DepartmentNode? root = this;
    while (root?.parent != null) {
      root = root?.parent;
    }
    traverse(root);
  }

  /// 深度优先遍历树 取消所有选中
  void traverse(DepartmentNode? root) {
    if (root != null) {
      root.select = false;
      root.children?.forEach((element) {
        element.traverse(element);
      });
    }
  }

  /// 查找ID所属的部门
  DepartmentNode? getDepartmentFromID(String? fromID) {
    if (fromID == null) {
      return null;
    }
    DepartmentNode? departmentNodeInfo;
    if (id == fromID) {
      return this;
    } else if (children?.isNotEmpty == true) {
      for (var value in children!) {
        departmentNodeInfo = value.getDepartmentFromID(fromID);
        if (departmentNodeInfo != null) {
          return departmentNodeInfo;
        }
      }
    }
    return null;
  }
}
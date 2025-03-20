import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:konesp/config/api.dart';
import 'package:konesp/entity/department_info_entity.dart';
import 'package:konesp/entity/department_node.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/widget/center_loading.dart';
import 'package:konesp/widget/empty_page.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/outlined_btn.dart';
import 'package:konesp/widget/search_widget.dart';
import 'package:konesp/widget/text_btn.dart';
import 'package:konesp/widget/title_bar.dart';

import 'department_logic.dart';

class DepartmentPage extends StatelessWidget {
  final logic = Get.find<DepartmentLogic>();
  final state = Get.find<DepartmentLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TitleBar(title: '部门'),
      body: DepartmentBody(
        logic: logic,
        initSearch: null,
        selectDepartment: state.selectedDepartment,
        onCancel: Get.back,
        onConfirm: (List<DepartmentNode> selectList) {
          Get.back(result: selectList);
        },
      ),
    );
  }
}

class DepartmentBody extends StatefulWidget {
  const DepartmentBody({
    Key? key,
    required this.logic,
    required this.onConfirm,
    required this.onCancel,
    this.selectDepartment,
    this.initSearch,
  }) : super(key: key);

  final DepartmentLogic logic;
  final String? initSearch;
  final DepartmentNode? selectDepartment;
  final Function() onCancel;
  final Function(List<DepartmentNode> selectList) onConfirm;

  @override
  State<DepartmentBody> createState() => _DepartmentBodyState();
}

class _DepartmentBodyState extends State<DepartmentBody> {
  /// 0-加载中  1-成功  2-失败
  int loadingState = 0;
  String? errorTip;

  List<DepartmentNode> dataList = [];
  final List<DepartmentNode> _showDataList = [];
  List<DepartmentNode> selectDataList = [];

  StateSetter? selectDataState;

  /// 显示的部门列表  当前显示最后一个
  List<DepartmentNode> showDepartmentList = [];

  var textController = TextEditingController();
  var focusNode = FocusNode();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData({bool init = true}) async {
    errorTip = null;
    if (!init) {
      setState(() {
        loadingState = 0;
      });
    }
    final result = await widget.logic.get<List<DepartmentInfoEntity>>(Api.branchDepartment);
    if (result.success) {
      dataList.clear();
      _showDataList.clear();
      var departments = result.data?.map((e) => DepartmentNode.fromEntity(e)).toList();
      var selectID = widget.selectDepartment?.id;
      departments?.forEach((department) {
        department.initSingleCheck(selectID);
        dataList.add(department);
      });
      _showDataList.addAll(dataList);
      loadingState = 1;
      setState(() {});
      updateSelect();
    } else {
      loadingState = 2;
      errorTip = result.msg;
      setState(() {});
    }
  }

  void updateSelect() {
    selectDataList.clear();
    DepartmentNode? root = dataList.firstOrNull;
    while (root?.parent != null) {
      root = root?.parent;
    }
    traverseTree(root);

    if (selectDataState != null && mounted) {
      selectDataState!(() {});
    }
  }

  /// 遍历树  找到选中状态的model
  void traverseTree(DepartmentNode? root) {
    if (root != null) {
      if (root.select) {
        selectDataList.clear();
        selectDataList.add(root);
      }
      root.children?.forEach((element) {
        traverseTree(element);
      });
    }
  }

  void _startSearch() {
    String value = textController.text;
    _showDataList.clear();
    for (var uiItem in dataList) {
      _showDataList.addAll(uiItem.getContainsDepartments(value));
    }
    updateSelect();
  }

  @override
  Widget build(BuildContext context) {
    if (loadingState == 0) {
      return CenterLoading();
    }else if (loadingState == 2) {
      return ErrorPage();
    } else {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
            child: SearchWidget(
              controller: textController,
              focusNode: focusNode,
              onSearch: _startSearch,
              hintText: '请输入部门名称',
            ),
          ),
          Expanded(
            child: StatefulBuilder(builder: (context, state) {
              selectDataState = state;
              return Column(
                children: [
                  _buildHorizontalScrollSelected(),
                  Divider(height: 1, color: Colours.bg),
                  Expanded(
                    child: _showDataList.isEmpty
                        ? EmptyPage()
                        : ListView.builder(
                            itemCount: _showDataList.length,
                            itemBuilder: (_, index) => _itemBuilder(_showDataList[index]),
                            padding: EdgeInsets.zero,
                          ),
                  ),
                  _bottomButtons()
                ],
              );
            }),
          )
        ],
      );
    }
  }

  bool isAllCheck() {
    if (_showDataList.isEmpty) {
      return false;
    }
    for (var i = 0; i < _showDataList.length; ++i) {
      var item = _showDataList[i];
      if (!item.select) {
        return false;
      }
    }
    return true;
  }

  Container _bottomButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 12.w, bottom: 12.w + ScreenUtil().bottomBarHeight),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: OutlinedBtn(
                borderColor: Colours.primary,
                borderWidth: 1.w,
                onPressed: () {
                  if (showDepartmentList.isEmpty) {
                    widget.onCancel();
                  } else {
                    showDepartmentList.removeLast();
                    _showDataList.clear();
                    if (showDepartmentList.isEmpty) {
                      _showDataList.addAll(dataList);
                    } else {
                      _showDataList.addAll(showDepartmentList.last.children!);
                    }
                    setState(() {});
                  }
                },
                text: showDepartmentList.isEmpty ? '取消' : '返回',
                size: Size(double.infinity, 44.w),
                radius: 7.w,
                style: TextStyle(
                  color: Colours.primary,
                  fontSize: 17.sp,
                ),
              ),
            ),
            SizedBox(width: 28.w),
            Expanded(
              child: TextBtn(
                text: selectDataList.isEmpty ? '确定' : '确定(${selectDataList.length})',
                size: Size(double.infinity, 44.w),
                backgroundColor: Colours.primary,
                radius: 7.w,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                ),
                onPressed: selectDataList.isEmpty
                    ? null
                    : () {
                        widget.onConfirm(selectDataList);
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalScrollSelected() {
    String name = '';
    if (selectDataList.isNotEmpty) {
      var s = selectDataList.first;

      List<String?> departmentNameList = [];
      DepartmentNode? temp = s;
      do {
        departmentNameList.add(temp?.name);
        temp = temp?.parent;
      } while (temp != null);
      name = departmentNameList.reversed.join('/');
    }

    return Container(
      constraints: BoxConstraints(minHeight: 42.w),
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.w, top: 5.w, bottom: 5.w),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            '已选',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Colours.text_333,
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Text(
              name,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colours.text_333,
                fontSize: 14.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Offstage(
            offstage: selectDataList.isEmpty,
            child: InkWell(
              onTap: () {
                selectDataList.firstOrNull?.cancelAllSelect();
                selectDataList.clear();
                updateSelect();
              },
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.close_outlined,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemBuilder(DepartmentNode item) {
    var checkIcon = Icons.circle_outlined;
    if (item.select) {
      checkIcon = Icons.check_circle;
    }
    return Material(
      color: item.select ? const Color(0xFFEBF5FF) : Colors.white,
      child: InkWell(
        onTap: () {
          if (item.children?.isNotEmpty == true) {
            _showDataList.clear();
            _showDataList.addAll(item.children!);
            showDepartmentList.add(item);
          } else {
            item.singleCheck(!item.select);
          }
          updateSelect();
        },
        child: Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colours.bg,
              ),
            ),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  item.singleCheck(!item.select);
                  updateSelect();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    checkIcon,
                    size: 24,
                    color: item.select ? Colours.primary : Colours.text_333,
                  ),
                ),
              ),
              CircleText(
                name: item.name?.isNotEmpty == true ? item.name![0] : '无',
                color: item.select ? Colors.blue.withAlpha(100) : null,
                textColor: item.select ? Colours.primary : null,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _itemText(item.name ?? '-', item.select, Colours.text_333, 15.sp),
              ),
              if (item.children?.isNotEmpty == true)
                LoadSvgImage(
                  'arrow_right',
                  width: 8.w,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemText(String text, bool select, Color color, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: select ? FontWeight.w600 : null,
        color: select ? Colours.primary : color,
      ),
    );
  }
}

class CircleText extends StatelessWidget {
  final String? name;
  final double? size;
  final double? textSize;
  final Color? color;
  final Color? textColor;

  CircleText({
    this.name,
    this.size,
    this.textSize,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    var sizeN = size ?? 30.w;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    if (textScaleFactor != 1.0) {
      sizeN = (size ?? 30.w) * textScaleFactor;
    }
    return Container(
      width: sizeN,
      height: sizeN,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: color ?? Colors.grey.shade200,
      ),
      child: Text(
        name ?? '无',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: textSize ?? 16.sp,
          color: textColor ?? Colors.grey,
        ),
      ),
    );
  }
}

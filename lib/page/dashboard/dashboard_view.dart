import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:konesp/res/colors.dart';
import 'package:konesp/store/store.dart';
import 'package:konesp/util/date_util.dart';
import 'package:konesp/util/object_util.dart';
import 'package:konesp/widget/error_page.dart';
import 'package:konesp/widget/load_image.dart';
import 'package:konesp/widget/red_badge.dart';
import 'package:konesp/widget/swipe.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'dashboard_logic.dart';
import 'dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put<DashboardLogic>(DashboardLogic());
    final state = Get.find<DashboardLogic>().state;

    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 1) {
          logic.query();
        }
      },
      key: const Key('DashboardPage'),
      child: GetBuilder<DashboardLogic>(builder: (_) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Material(
            color: Colours.bg,
            child: Column(
              children: [
                Container(
                  color: Color(0xFF3D32D9),
                  padding: EdgeInsets.only(left: 15.w, right: 15.w, top: ScreenUtil().statusBarHeight + 20.w, bottom: 20.w),
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return Text(
                            'Hi，${StoreLogic.to.getUser()?.username ?? ''}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }),
                      ),
                      GetBuilder<DashboardLogic>(
                        id: 'weather',
                        builder: (_) {
                          if (state.weatherStatus == PageStatus.success) {
                            return Row(
                              children: [
                                Text(
                                  state.weatherEntity!.city!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                LoadSvgImage(
                                  logic.getIconByName(state.weatherEntity!.weather!),
                                  width: 16.w,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  '${state.weatherEntity!.temperature}°C',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            );
                          } else if (state.weatherStatus == PageStatus.error) {
                            return Text(
                              '定位加载失败',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            );
                          } else if (state.weatherStatus == PageStatus.empty) {
                            return InkWell(
                              onTap: logic.queryWeather,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 20.w,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    '开启定位',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return CupertinoActivityIndicator(color: Colors.white);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colours.bg),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15.w, top: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _Label(title: '今日任务'),
                                Text(
                                  DateUtil.formatDate(DateTime.now(), format: DateFormats.ymd),
                                  style: TextStyle(
                                    color: Colours.text_333,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
                            child: Row(
                              children: [
                                _Task(
                                  title: '故障报修',
                                  icon: 'fix',
                                  beginColor: Color(0xFFe0d5fa),
                                  endColor: Color(0xFFf6f2fd),
                                  number: state.dashboardEntity?.todayWorkSimpleInfo?.faultRepairUnfinishedSum,
                                  onItem: () => logic.toTaskTabByIndex(0),
                                ),
                                SizedBox(width: 30.w),
                                _Task(
                                  title: '例行保养',
                                  icon: 'regular',
                                  beginColor: Color(0xFFd0ddfc),
                                  endColor: Color(0xFFeaf0fe),
                                  number: state.dashboardEntity?.todayWorkSimpleInfo?.maintenanceUnfinishedSum,
                                  onItem: () => logic.toTaskTabByIndex(1),
                                ),
                              ],
                            ),
                          ),
                          GetBuilder<DashboardLogic>(
                            id: 'grids',
                            builder: (logic) {
                              if (ObjectUtil.isEmpty(state.grids)) {
                                return SizedBox();
                              }
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20.w),
                                  _Label(title: '功能操作'),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 100.w,
                                    child: Swiper(
                                      circular: false,
                                      autoStart: false,
                                      indicator: RectangleSwiperIndicator(
                                        itemHeight: 4.w,
                                        itemWidth: 9.w,
                                        padding: EdgeInsets.zero,
                                        selectedItemColor: Colours.primary,
                                        itemColor: Colours.text_ccc,
                                        spacing: 3.w,
                                      ),
                                      indicatorAlignment: AlignmentDirectional.bottomCenter,
                                      children: List.generate(
                                        (state.grids.length / 5).ceil(),
                                        (index) {
                                          int startIndex = index * 5;
                                          int endIndex = (startIndex + 5) > state.grids.length ? state.grids.length : (startIndex + 5);
                                          return Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                                            child: Row(
                                              children: List.generate(
                                                endIndex - startIndex,
                                                (innerIndex) => _GridCell(entity: state.grids[startIndex + innerIndex]),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 20.w),
                          _Label(title: '设备概览'),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.w),
                            ),
                            margin: EdgeInsets.only(left: 15.w, top: 15.w, right: 15.w),
                            child: MasonryGridView.count(
                              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
                              crossAxisCount: 4,
                              mainAxisSpacing: 20.w,
                              shrinkWrap: true,
                              itemCount: logic.equipmentSummary.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => _Item(dataSource: logic.equipmentSummary[index]),
                            ),
                          ),
                          SizedBox(height: 20.w),
                          _Label(title: '待办工单'),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.w),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
                            child: MasonryGridView.count(
                              padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
                              crossAxisCount: 4,
                              mainAxisSpacing: 20.w,
                              shrinkWrap: true,
                              itemCount: logic.todos.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => _Item(dataSource: logic.todos[index]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({
    required GridModel entity,
  }) : _entity = entity;

  final GridModel _entity;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _entity.onTap,
      child: Container(
        width: (1.sw - 20.w) / 5,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  margin: EdgeInsets.all(3.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _entity.color,
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  child: LoadSvgImage(
                    _entity.icon,
                    width: 28.w,
                    height: 28.w,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: RedBadge(number: _entity.number),
                ),
              ],
            ),
            SizedBox(height: 5.w),
            Text(
              _entity.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colours.text_333,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: Text(
        title,
        style: TextStyle(
          color: Colours.text_333,
          fontWeight: FontWeight.w600,
          fontSize: 15.sp,
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.dataSource,
  });

  final Map dataSource;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          (dataSource['number'] ?? 0).toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colours.text_333,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 10.w),
        Text(
          dataSource['title'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colours.text_666,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class _Task extends StatelessWidget {
  const _Task({
    required this.icon,
    required this.title,
    required this.beginColor,
    required this.endColor,
    this.number,
    this.onItem,
  });

  final String icon;
  final String title;
  final Color beginColor;
  final Color endColor;
  final int? number;
  final Function()? onItem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onItem,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 85.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                gradient: LinearGradient(
                  colors: [beginColor, endColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              bottom: 5.w,
              right: 5.w,
              child: LoadAssetImage(
                icon,
                width: 40.w,
              ),
            ),
            Positioned(
              top: 10.w,
              left: 10.w,
              child: Text(
                title,
                style: TextStyle(
                  color: Colours.text_333,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
            ),
            Positioned(
              bottom: 10.w,
              left: 10.w,
              child: Text(
                (number ?? 0).toString(),
                style: TextStyle(
                  color: Colours.text_333,
                  fontWeight: FontWeight.w500,
                  fontSize: 28.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

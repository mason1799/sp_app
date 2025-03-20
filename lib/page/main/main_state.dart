import 'package:flutter/material.dart';
import 'package:konesp/widget/keep_alive_page.dart';
import 'package:konesp/widget/my_bottom_bar.dart';

import '../dashboard/dashboard_view.dart';
import '../message/message_view.dart';
import '../mine/mine_view.dart';
import '../task/task_view.dart';

class MainState {
  final pageController = PageController();
  late int selectedIndex;
  late List<Widget> tabPage;
  late List<BottomBarItem> tabBar;

  MainState() {
    selectedIndex = 0;
    tabPage = [
      keepAlivePage(DashboardPage()),
      keepAlivePage(TaskPage()),
      Container(),
      keepAlivePage(MessagePage()),
      keepAlivePage(MinePage()),
    ];
    tabBar = [
      BottomBarItem(icon: 'dashboard', activeIcon: 'dashboard_s', title: '工作台'),
      BottomBarItem(icon: 'task', activeIcon: 'task_s', title: '工单'),
      BottomBarItem(),
      BottomBarItem(icon: 'message', activeIcon: 'message_s', title: '消息'),
      BottomBarItem(icon: 'mine', activeIcon: 'mine_s', title: '我的'),
    ];
  }
}

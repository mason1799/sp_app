import 'package:flutter/material.dart';

class HelpState {
  late List<HelpModel> rookies;
  late List<HelpModel> functions;
  late List<HelpModel> tools;
  late List<HelpModel> problems;

  HelpState() {
    rookies = [
      HelpModel(
        title: '仟帆\n是什么',
        icon: 'safeguard',
        background: Color(0xFFD8EEF9),
        titleColor: Color(0xFF397398),
      ),
      HelpModel(
        title: '下载\n与安装',
        icon: 'safeguard',
        background: Color(0xFFF1EAFC),
        titleColor: Color(0xFF744FBF),
      ),
      HelpModel(
        title: '故障\n诊断工具',
        icon: 'safeguard',
        background: Color(0xFFECEFFB),
        titleColor: Color(0xFF3250A9),
      ),
    ];
    functions = [
      HelpModel(
        title: '设备管理',
        icon: 'contract',
      ),
      HelpModel(
        title: '人员管理',
        icon: 'contract',
      ),
      HelpModel(
        title: '合同管理',
        icon: 'contract',
      ),
      HelpModel(
        title: '走修建单',
        icon: 'contract',
      ),
      HelpModel(
        title: '走修回复',
        icon: 'contract',
      ),
      HelpModel(
        title: '保养回复',
        icon: 'contract',
      ),
      HelpModel(
        title: '客户签字',
        icon: 'contract',
      ),
    ];
    tools = [
      HelpModel(
        title: '工具介绍',
        icon: 'service_group',
      ),
      HelpModel(
        title: '权限申请',
        icon: 'service_group',
      ),
      HelpModel(
        title: '开始使用',
        icon: 'service_group',
      ),
    ];
    problems = [
      HelpModel(
        title: '工单可以提前回复吗？',
      ),
      HelpModel(
        title: '工单可以延后回复吗？',
      ),
      HelpModel(
        title: '工单可以转派他人吗？',
      ),
      HelpModel(
        title: '现场照片能自动保存到手机相册吗？',
      ),
      HelpModel(
        title: '登录时忘记密码怎么办？',
      ),
    ];
  }
}

class HelpModel {
  String title;
  String? icon;
  Color? background;
  Color? titleColor;
  String? url;

  HelpModel({
    required this.title,
    this.icon,
    this.background,
    this.titleColor,
    this.url,
  });
}

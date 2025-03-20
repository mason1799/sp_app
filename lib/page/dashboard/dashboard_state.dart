import 'package:flutter/material.dart';
import 'package:konesp/entity/dashboard_entity.dart';
import 'package:konesp/entity/weather_entity.dart';
import 'package:konesp/widget/error_page.dart';

class DashboardState {
  DashboardEntity? dashboardEntity;
  late PageStatus pageStatus;
  WeatherEntity? weatherEntity;
  late PageStatus weatherStatus;
  late List<GridModel> grids;

  DashboardState() {
    pageStatus = PageStatus.loading;
    weatherStatus = PageStatus.loading;
    grids = [];
  }
}

class GridModel {
  String title;
  String icon;
  Color color;
  int number;
  Function() onTap;

  GridModel({
    required this.title,
    required this.icon,
    required this.color,
    this.number = 0,
    required this.onTap,
  });
}

import 'package:flutter/material.dart';

class TwoDimensionalState {
  late String title;
  late List<Map<String, List<String>>> data;
  String? selected;
  late FixedExtentScrollController firstController;
  late FixedExtentScrollController secondController;
  late int firstIndex;
  late int secondIndex;
  late List<String> firstData;
  late List<String> secondData;
  Function(String firstValue, String secondValue)? resultData;
}

import 'package:flutter/material.dart';

class ThreeDimensionalState {
  String? title;
  String? selected;
  late List<Map<String, List<Map<String, List<String>>>>> data;
  late FixedExtentScrollController firstController;
  late FixedExtentScrollController secondController;
  late FixedExtentScrollController thirdController;
  late int firstIndex;
  late int secondIndex;
  late int thirdIndex;
  late List<String> firstData;
  late List<String> secondData;
  late List<String> thirdData;
  Function(String firstValue, String secondValue, String thirdValue)? resultData;
}

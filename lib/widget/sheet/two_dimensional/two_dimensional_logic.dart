import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konesp/util/object_util.dart';

import 'two_dimensional_state.dart';

class TwoDimensionalLogic extends GetxController {
  final TwoDimensionalState state = TwoDimensionalState();

  TwoDimensionalLogic(
    String title,
    List<Map<String, List<String>>> data,
    String? selected,
    Function(String firstValue, String secondValue)? resultData,
  ) {
    state.title = title;
    state.data = data;
    state.selected = selected;
    state.resultData = resultData;

    if (ObjectUtil.isNotEmpty(selected) && selected!.contains('/')) {
      String _firstValue = selected.split('/').first;
      String _secondValue = selected.split('/').last;
      state.firstData = [];
      state.data.map((item) => state.firstData.addAll(item.keys)).toList();
      int _index = state.firstData.indexOf(_firstValue);
      if (_index > -1) {
        state.firstIndex = _index;
      } else {
        state.firstIndex = 0;
      }
      state.secondData = state.data[state.firstIndex].values.first;
      int _index2 = state.secondData.indexOf(_secondValue);
      if (_index2 > -1) {
        state.secondIndex = _index2;
      } else {
        state.secondIndex = 0;
      }
    } else {
      state.firstIndex = 0;
      state.secondIndex = 0;
      state.firstData = [];
      state.data.map((item) => state.firstData.addAll(item.keys)).toList();
      state.secondData = state.data.first.values.first;
    }
    state.firstController = FixedExtentScrollController(initialItem: state.firstIndex);
    state.secondController = FixedExtentScrollController(initialItem: state.secondIndex);
  }

  void onChangeFirst(int index) {
    state.firstIndex = index;
    state.secondData = state.data[index].values.first;
    state.secondController.animateToItem(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
    update(['second']);
  }

  void onChangeSecond(int index) {
    state.secondIndex = index;
  }
}

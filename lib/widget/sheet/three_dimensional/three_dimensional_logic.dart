import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konesp/util/object_util.dart';

import 'three_dimensional_state.dart';

class ThreeDimensionalLogic extends GetxController {
  final ThreeDimensionalState state = ThreeDimensionalState();

  ThreeDimensionalLogic(
    String title,
    List<Map<String, List<Map<String, List<String>>>>> data,
    String? selected,
    Function(String firstValue, String secondValue, String thirdValue)? resultData,
  ) {
    state.title = title;
    state.data = data;
    state.selected = selected;
    state.resultData = resultData;

    //init datas
    if (ObjectUtil.isNotEmpty(selected) && selected!.contains('/')) {
      String _firstValue = selected.split('/')[0];
      String _secondValue = selected.split('/')[1];
      String _thirdValue = selected.split('/')[2];
      state.firstData = [];
      state.data.map((item) => state.firstData.addAll(item.keys)).toList();
      int _index = state.firstData.indexOf(_firstValue);
      if (_index > -1) {
        state.firstIndex = _index;
      } else {
        state.firstIndex = 0;
      }
      state.secondData = [];
      state.data[state.firstIndex].values.first.map((item) => state.secondData.addAll(item.keys)).toList();
      int _index2 = state.secondData.indexOf(_secondValue);
      if (_index2 > -1) {
        state.secondIndex = _index2;
      } else {
        state.secondIndex = 0;
      }
      state.thirdData = state.data[state.firstIndex].values.first.first[_secondValue]!;
      int _index3 = state.thirdData.indexOf(_thirdValue);
      if (_index3 > -1) {
        state.thirdIndex = _index3;
      } else {
        state.thirdIndex = 0;
      }
    } else {
      state.firstIndex = 0;
      state.secondIndex = 0;
      state.thirdIndex = 0;
      state.firstData = [];
      state.secondData = [];
      state.data.map((item) => state.firstData.addAll(item.keys)).toList();
      state.data.first.values.first.map((item) => state.secondData.addAll(item.keys)).toList();
      state.thirdData = state.data.first.values.first.first.values.first;
    }
    state.firstController = FixedExtentScrollController(initialItem: state.firstIndex);
    state.secondController = FixedExtentScrollController(initialItem: state.secondIndex);
    state.thirdController = FixedExtentScrollController(initialItem: state.thirdIndex);
  }

  void onChangeFirst(int index) {
    state.firstIndex = index;
    state.secondData.clear();
    state.data[state.firstIndex].values.first.map((item) => state.secondData.addAll(item.keys)).toList();
    state.secondController.animateToItem(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
    update(['second']);
    state.secondIndex = 0;
    state.thirdData = state.data[state.firstIndex].values.first.first.values.first;
    state.thirdController.animateToItem(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
    update(['third']);
  }

  void onChangeSecond(int index) {
    state.secondIndex = index;
    state.thirdData = state.data[state.firstIndex].values.first.first[state.secondData[state.secondIndex]]!;
    state.thirdController.animateToItem(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
    update(['third']);
  }

  void onChangeThird(int index) {
    state.thirdIndex = index;
  }
}

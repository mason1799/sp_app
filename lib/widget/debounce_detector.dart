import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// 防抖检测
class DebounceDetector extends StatefulWidget {
  const DebounceDetector({
    super.key,
    this.visibleQuery,
    required this.keyValue,
    required this.child,
  });

  final Function()? visibleQuery;
  final String keyValue;
  final Widget child;

  @override
  State<DebounceDetector> createState() => _DebounceDetectorState();
}

class _DebounceDetectorState extends State<DebounceDetector> {
  Timer? _debounce;
  bool _hasQueried = false; // 标志是否已查询过

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 1) {
          // 页面完全可见时，触发查询
          if (!_hasQueried) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 200), () {
              widget.visibleQuery?.call();
              _hasQueried = true; // 标记查询已执行
            });
          }
        } else {
          // 页面不可见时重置查询标志
          _hasQueried = false;
        }
      },
      key: Key(widget.keyValue),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

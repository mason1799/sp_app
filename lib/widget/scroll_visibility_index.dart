import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollVisibilityIndexWidget extends StatelessWidget {
  final ScrollView child;
  final Function(int first) callback;
  final Function(ScrollUpdateNotification notification)? scrollCallback;
  final Function()? scrollStart;
  final Function()? scrollEnd;

  const ScrollVisibilityIndexWidget({
    Key? key,
    required this.child,
    required this.callback,
    this.scrollCallback,
    this.scrollStart,
    this.scrollEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(onNotification: _onNotification, child: child);
  }

  bool _onNotification(ScrollNotification notice) {
    if (notice.metrics.axis == Axis.horizontal) {
      return false;
    }
    if (notice is ScrollStartNotification) {
      scrollStart?.call();
    } else if (notice is ScrollEndNotification) {
      scrollEnd?.call();
    } else if (notice is ScrollUpdateNotification) {
      scrollCallback?.call(notice);
    }
    final SliverMultiBoxAdaptorElement sliverMultiBoxAdaptorElement = findSliverMultiBoxAdaptorElement(notice.context! as Element)!;
    List<int> indexList = [];
    void onVisitChildren(Element element) {
      final SliverMultiBoxAdaptorParentData oldParentData = element.renderObject?.parentData as SliverMultiBoxAdaptorParentData;
      double layoutOffset = oldParentData.layoutOffset!;
      double pixels = notice.metrics.pixels;
      if (layoutOffset >= pixels) {
        indexList.add(oldParentData.index!);
      }
      if (sliverMultiBoxAdaptorElement.childCount == oldParentData.index! + 1 && layoutOffset < pixels) {
        indexList.add(oldParentData.index!);
      }
    }

    sliverMultiBoxAdaptorElement.visitChildren(onVisitChildren);
    callback(
      indexList.isNotEmpty ? indexList.first : 0,
    );
    return false;
  }

  SliverMultiBoxAdaptorElement? findSliverMultiBoxAdaptorElement(Element element) {
    if (element is SliverMultiBoxAdaptorElement) {
      return element;
    }
    SliverMultiBoxAdaptorElement? target;
    element.visitChildElements((child) {
      target = findSliverMultiBoxAdaptorElement(child);
    });
    return target;
  }
}

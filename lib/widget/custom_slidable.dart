import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomSlidable extends StatefulWidget {
  const CustomSlidable({
    super.key,
    this.groupTag,
    this.enabled = true,
    this.closeOnScroll = true,
    this.behavior = HitTestBehavior.deferToChild,
    this.startActionPane,
    this.endActionPane,
    this.direction = Axis.horizontal,
    this.dragStartBehavior = DragStartBehavior.start,
    this.useTextDirection = true,
    required this.child,
  });

  final Object? groupTag;
  final bool enabled;
  final bool closeOnScroll;
  final ActionPane? startActionPane;
  final ActionPane? endActionPane;
  final Axis direction;
  final DragStartBehavior dragStartBehavior;
  final bool useTextDirection;
  final Widget child;
  final HitTestBehavior behavior;

  @override
  State<CustomSlidable> createState() => _CustomSlidableState();
}

class _CustomSlidableState extends State<CustomSlidable> with TickerProviderStateMixin {
  late final SlidableController _controller;
  late bool _isActionPaneOpen;

  @override
  void initState() {
    super.initState();
    _controller = SlidableController(this);
    _isActionPaneOpen = false;
    _controller.actionPaneType.addListener(_actionPaneTypeListener);
  }

  @override
  void dispose() {
    _controller.actionPaneType.removeListener(_actionPaneTypeListener);
    _controller.dispose();
    super.dispose();
  }

  void _actionPaneTypeListener() {
    if (_controller.actionPaneType.value != ActionPaneType.none && !_controller.closing && !_isActionPaneOpen) {
      setState(() {
        _isActionPaneOpen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      behavior: widget.behavior,
      enabled: _isActionPaneOpen,
      onTapOutside: (_) {
        _controller.close();
        setState(() {
          _isActionPaneOpen = false;
        });
      },
      child: Slidable(
        key: widget.key,
        controller: _controller,
        groupTag: widget.groupTag,
        enabled: widget.enabled,
        closeOnScroll: widget.closeOnScroll,
        startActionPane: widget.startActionPane,
        endActionPane: widget.endActionPane,
        direction: widget.direction,
        dragStartBehavior: widget.dragStartBehavior,
        useTextDirection: widget.useTextDirection,
        child: widget.child,
      ),
    );
  }
}

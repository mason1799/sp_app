import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:konesp/widget/load_image.dart';

class CustomExpandableIcon extends StatefulWidget {
  final ExpandableThemeData? theme;
  final String? downPath;
  final String? upPath;
  final double? width;
  final double? height;

  CustomExpandableIcon({
    Key? key,
    this.theme,
    this.downPath,
    this.upPath,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<CustomExpandableIcon> createState() => _CustomExpandableIconState();
}

class _CustomExpandableIconState extends State<CustomExpandableIcon> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  ExpandableThemeData? theme;
  ExpandableController? controller;

  @override
  void initState() {
    super.initState();
    final theme = ExpandableThemeData.withDefaults(widget.theme, context, rebuildOnChange: false);
    animationController = AnimationController(duration: Duration.zero, vsync: this);
    animation = animationController!.drive(Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: theme.sizeCurve!)));
    controller = ExpandableController.of(context, rebuildOnChange: false, required: true);
    controller?.addListener(_expandedStateChanged);
    if (controller?.expanded ?? true) {
      animationController!.value = 1.0;
    }
  }

  @override
  void dispose() {
    controller?.removeListener(_expandedStateChanged);
    animationController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomExpandableIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      theme = null;
    }
  }

  _expandedStateChanged() {
    if (controller!.expanded && const [AnimationStatus.dismissed, AnimationStatus.reverse].contains(animationController!.status)) {
      animationController!.forward();
    } else if (!controller!.expanded && const [AnimationStatus.completed, AnimationStatus.forward].contains(animationController!.status)) {
      animationController!.reverse();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller2 = ExpandableController.of(context, rebuildOnChange: false, required: true);
    if (controller2 != controller) {
      controller?.removeListener(_expandedStateChanged);
      controller = controller2;
      controller?.addListener(_expandedStateChanged);
      if (controller?.expanded ?? true) {
        animationController!.value = 1.0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ExpandableThemeData.withDefaults(widget.theme, context);

    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        final showSecondIcon = theme.collapseIcon! != theme.expandIcon! && animationController!.value >= 0.5;
        return Transform.rotate(
          angle: theme.iconRotationAngle! * (showSecondIcon ? -(1.0 - animationController!.value) : animationController!.value),
          child: LoadSvgImage(
            showSecondIcon ? widget.upPath ?? 'ticket_arrow' : widget.downPath ?? 'ticket_arrow_down',
            width: widget.width ?? 17,
            height: widget.height ?? 17,
          ),
        );
      },
    );
  }
}

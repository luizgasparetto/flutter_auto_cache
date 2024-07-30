import 'package:flutter/material.dart';

import './extensions/getters_animation_status.dart';

import './extensions/getters_animation_direction.dart';
import 'enums/animation_direction.dart';

class AutoTransitionWidget extends StatefulWidget {
  final Widget child;
  final AnimationDirection direction;

  const AutoTransitionWidget({super.key, required this.child, this.direction = AnimationDirection.forward});

  @override
  _AutoTransitionWidgetState createState() => _AutoTransitionWidgetState();
}

class _AutoTransitionWidgetState extends State<AutoTransitionWidget> with SingleTickerProviderStateMixin {
  late bool hideWidget;

  Duration get duration => const Duration(milliseconds: 700);

  AnimationController get controller => AnimationController(duration: duration, vsync: this);

  double get begin => widget.direction == AnimationDirection.forward ? 0.0 : 1.0;
  double get end => widget.direction == AnimationDirection.forward ? 1.0 : 0.0;

  CurvedAnimation get curved => CurvedAnimation(parent: controller, curve: Curves.easeOut);
  Animation<double> get opacity => Tween<double>(begin: begin, end: end).animate(curved);

  @override
  void initState() {
    super.initState();

    controller.forward();
    hideWidget = false;

    if (widget.direction.isReverse) opacity.addStatusListener(animationStatusChange);
  }

  @override
  void didUpdateWidget(AutoTransitionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (Widget.canUpdate(oldWidget.child, widget.child)) return;
    opacity.removeStatusListener(animationStatusChange);

    this.updateWidgetForward();

    if (widget.direction.isReverse) opacity.addStatusListener(animationStatusChange);
  }

  @override
  void dispose() {
    opacity.removeStatusListener(animationStatusChange);
    controller.dispose();
    super.dispose();
  }

  void animationStatusChange(AnimationStatus status) {
    setState(() => hideWidget = widget.direction.isReverse && status.isCompleted);
  }

  void updateWidgetForward() {
    controller.duration = duration;
    controller.value = 0;

    controller.forward();
    hideWidget = false;
  }

  @override
  Widget build(BuildContext context) {
    if (hideWidget) return const SizedBox.shrink();

    return FadeTransition(opacity: opacity, child: widget.child);
  }
}

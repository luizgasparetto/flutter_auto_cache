import 'package:flutter/widgets.dart';

import '../../transitions/auto_transition_widget.dart';
import '../../transitions/enums/animation_direction.dart';

class StackMultiStateImage extends StatefulWidget {
  final Widget revealing;
  final Widget? disappearing;

  const StackMultiStateImage({
    super.key,
    required this.revealing,
    required this.disappearing,
  });

  @override
  State<StackMultiStateImage> createState() => _StackMultiStateImageState();
}

class _StackMultiStateImageState extends State<StackMultiStateImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.center,
      children: [
        AutoTransitionWidget(child: widget.revealing),
        AutoTransitionWidget(direction: AnimationDirection.reverse, child: widget.disappearing ?? const SizedBox.shrink())
      ],
    );
  }
}

import '../enums/animation_direction.dart';

extension GettersAnimationDirections on AnimationDirection {
  bool get isForward => this == AnimationDirection.forward;
  bool get isReverse => this == AnimationDirection.reverse;
}

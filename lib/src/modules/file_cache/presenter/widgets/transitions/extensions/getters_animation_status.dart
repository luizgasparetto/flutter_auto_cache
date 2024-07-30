import 'package:flutter/material.dart';

extension GettersAnimationStatus on AnimationStatus {
  bool get isCompleted => this == AnimationStatus.completed;
  bool get isForward => this == AnimationStatus.forward;
  bool get isDismissed => this == AnimationStatus.dismissed;
  bool get isReverse => this == AnimationStatus.reverse;
}

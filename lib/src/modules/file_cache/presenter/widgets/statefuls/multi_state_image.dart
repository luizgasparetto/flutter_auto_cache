import 'package:flutter/material.dart';

import '../../../../../core/shared/extensions/nullable_extensions.dart';
import 'internals/stack_multi_state_image.dart';

enum PlaceholderType { normal, none }

typedef MultiStateWidgetCallback = Widget Function(BuildContext context);

class MultiStateImage extends StatefulWidget {
  final ImageProvider image;
  final MultiStateWidgetCallback? placeholderBuilder;
  final MultiStateWidgetCallback? errorBuilder;
  final FilterQuality filterQuality;
  final BoxFit fit;

  MultiStateImage({
    super.key,
    required ImageProvider image,
    this.placeholderBuilder,
    this.errorBuilder,
    this.filterQuality = FilterQuality.medium,
    this.fit = BoxFit.contain,
    int? memCacheWidth,
    int? memCacheHeight,
  }) : this.image = ResizeImage.resizeIfNeeded(memCacheWidth, memCacheHeight, image);

  @override
  State<MultiStateImage> createState() => _MultiStateImageState();
}

class _MultiStateImageState extends State<MultiStateImage> {
  @override
  Widget build(BuildContext context) {
    return Image(
      key: ValueKey(widget.image),
      image: widget.image,
      fit: widget.fit,
      errorBuilder: (ctx, _, __) => widget.errorBuilder.let((error) => error.call(ctx)) ?? const SizedBox.shrink(),
      frameBuilder: (_, child, frame, wasLoaded) => _ImageBuilder(child, frame, wasLoaded, builder: widget.placeholderBuilder),
      filterQuality: widget.filterQuality,
    );
  }
}

class _ImageBuilder extends StatelessWidget {
  final Widget child;
  final bool wasLoaded;
  final int? frame;
  final MultiStateWidgetCallback? builder;

  const _ImageBuilder(
    this.child,
    this.frame,
    this.wasLoaded, {
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    if (builder == null || wasLoaded) return child;
    if (frame == null) return builder?.call(context) ?? const SizedBox.shrink();

    return StackMultiStateImage(revealing: child, disappearing: builder?.call(context));
  }
}

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
      frameBuilder: _imageBuilder,
      filterQuality: widget.filterQuality,
    );
  }

  Widget _imageBuilder(BuildContext ctx, Widget child, int? frame, bool wasLoaded) {
    if (widget.placeholderBuilder == null) return child;

    return _placeholderBuilder(ctx, child, frame, wasLoaded);
  }

  Widget _placeholderBuilder(BuildContext ctx, Widget child, int? frame, bool wasLoaded) {
    if (wasLoaded) return child;
    if (frame == null) return widget.placeholderBuilder?.call(context) ?? const SizedBox.shrink();

    return StackMultiStateImage(revealing: child, disappearing: widget.placeholderBuilder?.call(context));
  }
}

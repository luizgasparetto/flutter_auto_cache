import 'package:flutter/material.dart';

import 'internals/stack_multi_state_image.dart';

enum PlaceholderType { normal, none }

class MultiStateImage extends StatefulWidget {
  final ImageProvider image;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final Widget? placeholderWidget;
  final FilterQuality filterQuality;
  final BoxFit fit;
  final String? semanticLabel;
  final BlendMode? colorBlendMode;
  final AlignmentGeometry alignment;

  MultiStateImage({
    super.key,
    required ImageProvider image,
    this.width,
    this.height,
    this.placeholderWidget,
    this.errorWidget,
    this.filterQuality = FilterQuality.medium,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.colorBlendMode,
    this.alignment = Alignment.center,
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
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      alignment: widget.alignment,
      colorBlendMode: widget.colorBlendMode,
      filterQuality: widget.filterQuality,
      semanticLabel: widget.semanticLabel,
      errorBuilder: (ctx, _, __) => widget.errorWidget ?? const SizedBox.shrink(),
      frameBuilder: (_, child, frame, loaded) => _ImageBuilder(child, frame, loaded, placeholder: widget.placeholderWidget),
    );
  }
}

class _ImageBuilder extends StatelessWidget {
  final Widget child;
  final bool loaded;
  final int? frame;
  final Widget? placeholder;

  const _ImageBuilder(this.child, this.frame, this.loaded, {required this.placeholder});

  @override
  Widget build(BuildContext context) {
    if (placeholder == null || loaded) return child;
    if (frame == null) return placeholder ?? const SizedBox.shrink();

    return StackMultiStateImage(revealing: child, disappearing: placeholder);
  }
}

import 'package:flutter/material.dart';

import 'statefuls/multi_state_image.dart';

class AutoNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Alignment alignment;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AutoNetworkImage({
    super.key,
    required this.imageUrl,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    // return MultiStateImage(
    //   image: ,
    // );

    return const SizedBox.shrink();
  }
}

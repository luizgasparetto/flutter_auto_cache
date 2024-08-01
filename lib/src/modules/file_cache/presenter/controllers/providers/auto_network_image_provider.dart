import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AutoNetworkImageProvider extends ImageProvider<AutoNetworkImageProvider> {
  @override
  Future<AutoNetworkImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<AutoNetworkImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(AutoNetworkImageProvider key, ImageDecoderCallback decode) {
    throw UnimplementedError();
  }
}

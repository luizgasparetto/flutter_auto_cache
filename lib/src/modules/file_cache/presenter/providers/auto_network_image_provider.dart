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
    final controller = StreamController<ImageChunkEvent>();

    // final imageStreamCompleter = MultiImageStreamCompleter(
    //   codec: _loadImageAsync(key, chunkEvents, decode),
    //   chunkEvents: chunkEvents.stream,
    //   scale: key.scale,
    //   informationCollector: () sync* {
    //     yield DiagnosticsProperty<ImageProvider>(
    //       'Image provider: $this \n Image key: $key',
    //       this,
    //       style: DiagnosticsTreeStyle.errorProperty,
    //     );
    //   },
    // );

    // if (errorListener != null) {
    //   imageStreamCompleter.addListener(
    //     ImageStreamListener(
    //       (image, synchronousCall) {},
    //       onError: (Object error, StackTrace? trace) {
    //         errorListener?.call(error);
    //       },
    //     ),
    //   );
    // }

    // return imageStreamCompleter;
  }
}

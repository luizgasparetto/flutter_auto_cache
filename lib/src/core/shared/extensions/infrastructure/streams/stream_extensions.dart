import 'dart:async';

extension InteractStreamExtension<T> on Stream<T> {
  void interact(StreamController<T> controller) {
    this.listen(
      (event) => controller.add(event),
      onDone: () => controller.close(),
      onError: (covariant Object error) {
        controller.addError(error);
        controller.close();
      },
    );
  }
}

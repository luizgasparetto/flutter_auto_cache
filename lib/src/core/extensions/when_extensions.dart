import 'package:mocktail/mocktail.dart';

extension WhenAsyncVoid on When {
  void thenAsyncVoid() {
    return thenAnswer((_) async {});
  }
}

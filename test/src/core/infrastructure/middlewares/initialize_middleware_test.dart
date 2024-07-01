import 'package:flutter_auto_cache/src/core/infrastructure/middlewares/exceptions/initializer_exceptions.dart';
import 'package:flutter_auto_cache/src/core/infrastructure/middlewares/initialize_middleware.dart';
import 'package:flutter_auto_cache/src/core/services/service_locator/implementations/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeInstance extends Fake {}

void main() {
  final fakeInstance = FakeInstance();

  tearDown(() {
    ServiceLocator.instance.resetBinds();
  });

  group('InitializeMiddleware.accessInstance |', () {
    test('should be able to access instance when has injections', () {
      ServiceLocator.instance.bindFactory(() => FakeInstance());

      final response = InitializeMiddleware.accessInstance(() => fakeInstance);

      expect(response, equals(fakeInstance));
    });

    test("should NOT be able access instance when doesn't contains injections", () {
      expect(
        () => InitializeMiddleware.accessInstance(() => fakeInstance),
        throwsA(isA<NotInitializedAutoCacheException>()),
      );
    });
  });
}

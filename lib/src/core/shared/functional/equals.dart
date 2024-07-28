abstract class Equals {
  const Equals();

  final props = const <Object?>[];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is! Equals) return false;

    return props.asMap().entries.every((entry) => entry.value == other.props[entry.key]);
  }

  @override
  int get hashCode => props.fold(0, (prev, next) => prev ^ next.hashCode);
}

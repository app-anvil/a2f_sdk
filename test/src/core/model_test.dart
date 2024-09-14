import 'package:a2f_sdk/src/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

final class _Model extends Model {
  final String field;

  const _Model(this.field);

  @override
  List<Object?> get props => [field];

  @override
  Map<String, dynamic> $toMap() => {'field': field};
}

void main() {
  test(
    'should use toString() of ModelToStringMixin and not of EquatableMixin',
    () {
      const model = _Model('value');
      final stringModel = model.toString();
      expect(
        stringModel,
        '_Model{field: value}',
      );
    },
  );
}

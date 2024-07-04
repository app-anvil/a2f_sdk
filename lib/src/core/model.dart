import '../../a2f_sdk.dart';

/// A common parent for models.
abstract class Model with ModelToStringMixin, EquatableMixin {
  const Model();
}

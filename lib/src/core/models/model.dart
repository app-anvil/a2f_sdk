import 'package:equatable/equatable.dart';

import '../core.dart';
import 'entity.dart';

/// A common parent for models.
abstract class Model with EquatableMixin, ModelToStringMixin implements Entity {
  const Model();
}

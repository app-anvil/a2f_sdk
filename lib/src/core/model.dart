import 'package:equatable/equatable.dart';

import '../../a2f_sdk.dart';

/// A common parent for models.
abstract class Model with EquatableMixin, ModelToStringMixin {
  const Model();
}

import 'package:flext_core/flext_core.dart';
import 'package:flutter/foundation.dart';

abstract interface class IModel {
  /// Returns a verbose string representation of this class.
  /// By default it includes all the fields of the class, but it can be
  /// configured to include only a subset of them by setting the [fieldCount]
  /// parameter.
  ///
  /// [fieldCount] must be >= 1.
  String toStringVerbose({int? fieldCount});

  /// Returns a short string representation of this class that includes only
  /// the [field] parameter value. If [field] is not provided, it defaults to
  /// the first field returned by the `$toMap` method.
  String toShortString({dynamic field});
}

/// Mixin to provide a way to a class with many fields to be logged without
/// being too verbose in the output logs.
///
/// The normal [toString] method is overridden to provide a short output
/// containing only the most meaningful fields of the class (e.g., id, name).
///
/// The [toStringVerbose] method, instead, can be used to get a more verbose
/// output. By default it prints all the fields of the class, but it can be
/// configured to print only a subset of them by passing the fieldCount
/// parameter.
mixin ModelToStringMixin implements IModel {
  /// The name of the model.
  ///
  /// It is used when printing this model to identify the model type.
  @protected
  String get $modelName => '$runtimeType';

  @nonVirtual
  @override
  String toString() => toStringVerbose(fieldCount: 3);

  @override
  @nonVirtual
  String toStringVerbose({int? fieldCount}) {
    assert(fieldCount == null || fieldCount > 0, '');
    var map = $toMap();
    if (fieldCount != null) {
      map = Map.fromEntries(map.entries.take(fieldCount));
    }
    final strMap = map.entries.map((e) => '${e.key}: ${e.value}').join(', ');
    return '${$modelName}{$strMap}';
  }

  /// Returns a map containing the fields of this model.
  ///
  /// In the implementation place the most meaningful fields first so that
  /// [toString] will print those first.
  @protected
  Map<String, dynamic> $toMap();

  @override
  String toShortString({dynamic field}) {
    final map = $toMap();
    final oneMember =
        (field != null ? map[field] : null) ?? map.values.firstOr('');
    return '${$modelName}{$oneMember}';
  }
}

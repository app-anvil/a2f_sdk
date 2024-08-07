/// {@template singleton_cache}
/// This class stores an item of type [O] in memory.
/// {@endtemplate}
class SingletonCache<O> {
  O? _item;

  /// Get the current item.
  ///
  /// Item can be null.
  O? get item => _item;

  /// Saves the [value] in memory.
  // ignore: use_setters_to_change_properties
  void save(O value) {
    _item = value;
  }

  /// Get the current item if exists, otherwise returns null.
  O? get() => _item;

  /// Returns the current item. it throws a `ItemIsNull` exception
  ///  if item is null.
  O getOrThrow() {
    final item = _item;
    if (item == null) throw StateError('Item not found in repository.');
    return item;
  }

  /// Updates the stored item with [value].
  // ignore: use_setters_to_change_properties
  void update(O value) {
    _item = value;
  }

  /// The same as clear method.
  void delete() {
    clear();
  }

  /// Set stored item equal to null.
  void clear() {
    _item = null;
  }
}

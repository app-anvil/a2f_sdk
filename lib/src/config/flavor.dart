/// Flavor to distinguish the running environment.
enum Flavor {
  /// Dev
  dev,

  /// Staging
  staging,

  /// Production
  prod;

  /// Returns if the flavor have to be shown or not.
  bool get show => this != prod;
}

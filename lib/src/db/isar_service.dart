import 'package:isar/isar.dart';

/// Interface for the Isar service.
///
/// The A2F SDK does not provide an implementation of this interface.
/// The implementation must be provided by the app.
///
/// The interface is defined in the SDK so that external packages may use it
/// by injecting it via GetIt.
abstract interface class IsarService {
  abstract Future<Isar> db;

  Future<Isar> openDB();
}

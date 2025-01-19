import 'package:boh_hummm/utils/result.dart';

abstract interface class IConnectionDb<T> {
  Future<Result<T>> initializeDatabase();
}

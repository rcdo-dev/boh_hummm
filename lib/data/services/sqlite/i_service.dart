import 'package:boh_hummm/utils/result.dart';

abstract interface class IService<T> {
  Future<Result<int>> create({required T data});

  Future<Result<List<Map<String, Object?>>>> readAll();

  Future<Result<T>> readById({required int id});

  Future<Result<int>> update({required T data});

  Future<Result<int>> delete({required T data});
}

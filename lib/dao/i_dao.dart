import 'package:boh_hummm/model/user_model.dart';

abstract interface class IDao<T> {
  Future<int> insert({required T data});

  Future<List<Map<String, Object?>>> getAll();

  Future<T> getById({required int id});

  Future<int> update({required T data});

  Future<int> delete({required T data});
}

abstract interface class IInsertDao<T> {
  Future<int> insert({required T data});
}

abstract interface class IDao<T> implements IInsertDao<T> {
  Future<List<T>> getAll();

  Future<T> getById({required int id});

  Future<int> update({required T data});

  Future<int> delete({required T data});
}

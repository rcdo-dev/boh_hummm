abstract interface class IRepository<T> {
  Future<void> insert({required T data});

  Future<List<T>> getAll();

  Future<T> getById({required int id});

  Future<void> update({required T data});

  Future<void> delete({required T data});
}

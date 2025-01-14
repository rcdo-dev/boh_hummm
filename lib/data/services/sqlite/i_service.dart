abstract interface class IService<T> {
  Future<int> create({required T data});

  Future<List<Map<String, Object?>>> readAll();

  Future<T> readById({required int id});

  Future<int> update({required T data});

  Future<int> delete({required T data});
}

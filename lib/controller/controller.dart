import 'package:boh_hummm/dao/i_dao.dart';

class Controller<T> {
  final IDao dao;

  Controller({
    required this.dao,
  });

  Future<int> addData(T data) async {
    return await dao.insert(data: data);
  }

  Future<List<Map<String, Object?>>> fetchAllData() async {
    return await dao.getAll();
  }

  Future<T> fetchDataById({required int id}) async {
    return await dao.getById(id: id);
  }

  Future<int> updateData({required T data}) async {
    return await dao.update(data: data);
  }

  Future<int> deleteData({required T data}) async {
    return await dao.delete(data: data);
  }
}

import 'package:boh_hummm/dao/i_dao.dart';
import 'package:boh_hummm/model/delivery_route_model.dart';

class DeliveryRouteDao implements IDao<DeliveryRouteModel> {
  @override
  Future<int> insert({required DeliveryRouteModel data}) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  /// Method not implemented. Do not use.
  @override
  Future<List<Map<String, Object?>>> getAll() {
    throw 'UnimplementedError()';
  }

  /// Method not implemented. Do not use.
  @override
  Future<DeliveryRouteModel> getById({required int id}) {
    throw UnimplementedError();
  }

  /// Method not implemented. Do not use.
  @override
  Future<int> update({required DeliveryRouteModel data}) {
    throw UnimplementedError();
  }

  @override
  Future<int> delete({required DeliveryRouteModel data}) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}

import 'package:boh_hummm/data/model/delivery_route_model.dart';
import 'package:boh_hummm/data/services/sqlite/connection_db/i_connection_db.dart';
import 'package:boh_hummm/data/services/sqlite/i_service.dart';
import 'package:boh_hummm/utils/result.dart';
import 'package:sqflite/sqflite.dart';

class DeliveryRouteService implements IService<DeliveryRouteModel> {
  final IConnectionDb connection;

  DeliveryRouteService({
    required this.connection,
  });

  @override
  Future<Result<int>> create({required DeliveryRouteModel data}) async {
    var result = await connection.initializeDatabase();

    if (result is Ok<Database>) {
      try {
        int lastId = await result.value.rawInsert(
          "INSERT INTO delivery_route(delr_identifier, delr_slo_id) VALUES (?, ?)",
          [data.delr_identifier, data.delr_slo_id],
        );
        return Result.ok(lastId);
      } on Exception catch (e, s) {
        Result.error(e, s);
      } finally {
        result.value.close();
      }
    }
    return Result.error(Exception('Error trying to enter a delivery route.'));
  }

  @override
  Future<Result<List<Map<String, Object?>>>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<Result<DeliveryRouteModel>> readById({required int id}) {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<Result<int>> update({required DeliveryRouteModel data}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Result<int>> delete({required DeliveryRouteModel data}) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}

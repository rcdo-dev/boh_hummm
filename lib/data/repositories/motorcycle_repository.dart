import 'package:boh_hummm/data/model/motorcycle_model.dart';
import 'package:boh_hummm/data/services/sqlite/impl/motorcycle_service.dart';
import 'package:boh_hummm/data/services/sqlite/impl/slope_service.dart';
import 'package:boh_hummm/data/services/sqlite/impl/user_service.dart';
import 'package:boh_hummm/domain/entities/motorcycle_entity.dart';
import 'package:boh_hummm/domain/entities/slope_entity.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';
import 'package:boh_hummm/utils/result.dart';

class MotorcycleRepository {
  final MotorcycleService _motorcycleService;
  final UserService _userService;
  final SlopeService _slopeService;

  MotorcycleRepository({
    required MotorcycleService motorcycleService,
    required UserService userService,
    required SlopeService slopeService,
  })  : _motorcycleService = motorcycleService,
        _userService = userService,
        _slopeService = slopeService;

  Future<Result<void>> createMotorcycle({
    required MotorcycleEntity motorcycleEntity,
    required int idUser,
  }) async {
    try {
      var motorcycle = MotorcycleModel(
        mot_brand: motorcycleEntity.brand,
        mot_type: motorcycleEntity.type,
        mot_cylinder_capacity: motorcycleEntity.cylinderCapacity,
        mot_use_id: idUser,
      );
      return _motorcycleService.create(data: motorcycle);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<List<MotorcycleEntity>>> readAllMotorcycles() async {
    try {
      var resultMotorcycles = await _motorcycleService.readAll();
      var resultUsers = await _userService.readAll();
      var resultSlopes = await _slopeService.readAll();

      var motorcycleEntity = resultMotorcycles.asOk.value.map((element) {
        var motUserId = element['mot_use_id'] as int;
        var motId = element['mot_id'] as int;

        var motorcycleUser = UserEntity();
        var motorcycleSlope = SlopeEntity();

        for (var user in resultUsers.asOk.value) {
          if (motUserId == user['use_id']) {
            motorcycleUser = UserEntity.fromMap(user);
          }
        }

        for (var slope in resultSlopes.asOk.value) {
          if (motId == slope['slo_mot_id']) {
            motorcycleSlope = SlopeEntity.fromMap(slope);
          }
        }

        return MotorcycleEntity(
          brand: element['mot_brand'] as String,
          type: element['mot_type'] as String,
          cylinderCapacity: element['mot_cylinder_capacity'] as double,
          user: motorcycleUser,
          slope: motorcycleSlope,
        );
      }).toList();

      return Result.ok(motorcycleEntity);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<MotorcycleEntity>> readMotorcycleById({required int id}) async {
    try {
      var resultMotorcycle = await _motorcycleService.readById(id: id);
      var motUseId = resultMotorcycle.asOk.value.mot_use_id;
      var motId = resultMotorcycle.asOk.value.mot_id;

      var userEntity = UserEntity();
      var slopeEntity = SlopeEntity();

      var resultUsers = await _userService.readAll();
      var resultSlopes = await _slopeService.readAll();

      for (var user in resultUsers.asOk.value) {
        if (motUseId == user['use_id']) {
          userEntity = UserEntity.fromMap(user);
        }
      }

      for (var slope in resultSlopes.asOk.value) {
        if (motId == slope['slo_mot_id']) {
          slopeEntity = SlopeEntity.fromMap(slope);
        }
      }

      var motorcycleEntity = MotorcycleEntity(
        brand: resultMotorcycle.asOk.value.mot_brand,
        type: resultMotorcycle.asOk.value.mot_type,
        cylinderCapacity: resultMotorcycle.asOk.value.mot_cylinder_capacity,
        user: userEntity,
        slope: slopeEntity,
      );

      return Result.ok(motorcycleEntity);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<void>> updateMotorcycle({
    required MotorcycleEntity motorcycleEntity,
  }) async {
    try {
      var resultMotorcycles = await _motorcycleService.readAll();
      var existingMoto = resultMotorcycles.asOk.value.firstWhere(
        (map) => map['mot_type'] == motorcycleEntity.type,
        orElse: () => {},
      );
      var motId = existingMoto['mot_id'] as int;

      if (existingMoto.isEmpty) {
        return Result.error(Exception('Motorcycle not found for update'));
      }

      return _motorcycleService.update(
        data: MotorcycleModel(
          mot_brand: motorcycleEntity.brand,
          mot_type: motorcycleEntity.type,
          mot_cylinder_capacity: motorcycleEntity.cylinderCapacity,
          mot_id: motId,
        ),
      );
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<void>> deleteMotorcycle({
    required MotorcycleEntity motorcycleEntity,
  }) async {
    try {
      var resultMotorcycles = await _motorcycleService.readAll();
      var existingMoto = resultMotorcycles.asOk.value.firstWhere(
        (map) => map['mot_type'] == motorcycleEntity.type,
        orElse: () => {},
      );
      var motId = existingMoto['mot_id'] as int;

      if (existingMoto.isEmpty) {
        return Result.error(Exception('Motorcycle not found for update'));
      }

      return _motorcycleService.delete(
        data: MotorcycleModel(
          mot_id: motId,
        ),
      );
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }
}

import 'package:boh_hummm/data/model/motorcycle_model.dart';
import 'package:boh_hummm/domain/entities/motorcycle_entity.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';
import 'package:boh_hummm/utils/result.dart';

import '../services/sqlite/impl/motorcycle_service.dart';
import '../services/sqlite/impl/user_service.dart';

class MotorcycleRepository {
  final MotorcycleService _motorcycleService;
  final UserService _userService;

  MotorcycleRepository({
    required MotorcycleService motorcycleService,
    required UserService userService,
  })  : _motorcycleService = motorcycleService,
        _userService = userService;

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
    var resultMotorcycles = await _motorcycleService.readAll();
    var resultUsers = await _userService.readAll();

    var userEntity = UserEntity();
    for (var motorcycle in resultMotorcycles.asOk.value) {
      var motUserId = motorcycle['mot_use_id'] as int;
      userEntity = UserEntity.fromMap(
        resultUsers.asOk.value
            .firstWhere((element) => element['use_id'] == motUserId),
      );
    }

    // Tem que ser uma lista de usuários

    var motorcycleEntity = resultMotorcycles.asOk.value.map((element) {
      return MotorcycleEntity(
        brand: element['mot_brand'] as String,
        type: element['mot_type'] as String,
        cylinderCapacity: element['mot_cylinder_capacity'] as double,
        user: userEntity,
      );
    }).toList();

    return Result.ok(motorcycleEntity);
  }
}

import 'package:boh_hummm/data/model/motorcycle_model.dart';
import 'package:boh_hummm/domain/entities/motorcycle_entity.dart';
import 'package:boh_hummm/utils/result.dart';

import '../services/sqlite/impl/motorcycle_service.dart';

class MotorcycleRepository {
  final MotorcycleService _motorcycleService;

  MotorcycleRepository({
    required MotorcycleService motorcycleService,
  }) : _motorcycleService = motorcycleService;

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
}

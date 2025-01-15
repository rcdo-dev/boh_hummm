import 'package:boh_hummm/data/services/sqlite/i_service.dart';
import 'package:boh_hummm/domain/entities/delivery_entity.dart';

class DeliveryRepository {
  final IService _service;

  DeliveryRepository({
    required IService service,
  }) : _service = service;

  Future<void> createDelivery({required DeliveryEntity delivery}) async {
    try {
      await _service.create(data: delivery);
    } catch (e, s) {}
    // Entender a classe Result do Dart.
  }
}

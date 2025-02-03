import 'package:boh_hummm/data/model/user_model.dart';
import 'package:boh_hummm/data/services/sqlite/impl/motorcycle_service.dart';
import 'package:boh_hummm/data/services/sqlite/impl/user_service.dart';
import 'package:boh_hummm/domain/entities/motorcycle_entity.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';
import 'package:boh_hummm/utils/result.dart';

class UserRepository {
  final UserService _userService;
  final MotorcycleService _motorcycleService;

  UserRepository({
    required UserService userService,
    required MotorcycleService motorcycleService,
  })  : _userService = userService,
        _motorcycleService = motorcycleService;

  Future<Result<void>> createUser({required UserEntity user}) async {
    try {
      var userModel = UserModel(
        use_name: user.name,
        use_email: user.email,
        use_image_path: user.imagePath,
      );
      return await _userService.create(data: userModel);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<List<UserEntity>>> readAllUsers() async {
    try {
      var result = await _userService.readAll();
      switch (result) {
        case Ok<List<Map>>():
          final listMap = result.asOk.value;
          return Result.ok(
            listMap.map((map) => UserEntity.fromMap(map)).toList(),
          );
        case Error<List<Map>>():
          return Result.error(result.asError.error);
      }
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<List<UserEntity>>> readAllUsersWithMotorcycles() async {
    try {
      var resultUsers = await _userService.readAll();
      var resultMotorcycles = await _motorcycleService.readAll();

      var motorcycleByUserId = <String, List<MotorcycleEntity>>{};
      for (var motorcycle in resultMotorcycles.asOk.value) {
        var motorcycleEntity = MotorcycleEntity.fromMap(motorcycle);
        var motorcycleOwnerUserId = motorcycle['mot_use_id'].toString();
        /*
        * A função putIfAbsent pertence ao Map;
        * Verifica se motorcycleOwnerUserId já existe no mapa (motorcyclesByUserId);
        * Se não existir, cria uma nova lista vazia ([]) para esse motorcycleOwnerUserId;
        * Se já existir, usa a lista existente; e
        * Em ambos os casos, adiciona (.add(motorcycleEntity)) a moto à lista correspondente.
        */
        motorcycleByUserId
            .putIfAbsent(motorcycleOwnerUserId, () => [])
            .add(motorcycleEntity);
      }

      var usersEntity = resultUsers.asOk.value.map((element) {
        var userId = element['use_id'].toString();
        return UserEntity(
          name: element['use_name'] as String,
          email: element['use_email'] as String,
          imagePath: element['use_image_path'] as String,
          motorcycles: motorcycleByUserId[userId] ?? [],
        );
      }).toList();

      return Result.ok(usersEntity);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<UserEntity>> readUserById({required int id}) async {
    try {
      var resultUser = await _userService.readById(id: id);
      var userEntity = UserEntity(
        name: resultUser.asOk.value.use_name,
        email: resultUser.asOk.value.use_email,
        imagePath: resultUser.asOk.value.use_image_path,
      );
      return Result.ok(userEntity);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<UserEntity>> readUserWithMotorcyclesById({
    required int id,
  }) async {
    try {
      var resultUser = await _userService.readById(id: id);
      var userId = resultUser.asOk.value.use_id;

      var resultMotorcycles = await _motorcycleService.readAll();

      var motorcycleList = <MotorcycleEntity>[];

      for (var motorcycle in resultMotorcycles.asOk.value) {
        if (resultMotorcycles.asOk.value
            .any((map) => map['mot_use_id'] == userId)) {
          var motorcycleEntity = MotorcycleEntity.fromMap(motorcycle);
          motorcycleList.add(motorcycleEntity);
        }
      }

      var userEntity = UserEntity(
        name: resultUser.asOk.value.use_name,
        email: resultUser.asOk.value.use_email,
        imagePath: resultUser.asOk.value.use_image_path,
        motorcycles: motorcycleList,
      );
      return Result.ok(userEntity);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<void>> updateUser({required UserEntity userEntity}) async {
    try {
      var resultUsers = await _userService.readAll();
      var existingUser = resultUsers.asOk.value.firstWhere(
            (map) => map['use_email'] == userEntity.email,
        orElse: () => {},
      );
      var userId = existingUser['use_id'] as int;

      if (existingUser.isEmpty) {
        return Result.error(Exception('User not found for update'));
      }

      return _userService.update(
        data: UserModel(
          use_id: userId,
          use_name: userEntity.name,
          use_email: userEntity.email,
          use_image_path: userEntity.imagePath,
        ),
      );
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<void>> deleteUser({required UserEntity userEntity}) async {
    try {
      var resultUsers = await _userService.readAll();
      var existingUser = resultUsers.asOk.value.firstWhere(
            (map) => map['use_email'] == userEntity.email,
        orElse: () => {},
      );
      var userId = existingUser['use_id'] as int;

      if (existingUser.isEmpty) {
        return Result.error(Exception('User not found for delete'));
      }

      return _userService.delete(
        data: UserModel(
          use_id: userId,
        ),
      );
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }
}
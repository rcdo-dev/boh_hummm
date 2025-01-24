import 'package:boh_hummm/data/model/user_model.dart';
import 'package:boh_hummm/data/services/sqlite/impl/user_service.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';
import 'package:boh_hummm/utils/result.dart';

class UserRepository {
  final UserService _userService;

  UserRepository({
    required UserService userService,
  }) : _userService = userService;

  Future<Result<void>> createUser({required UserEntity user}) async {
    try {
      final userModel = UserModel(
        use_name: user.name,
        use_email: user.email,
        use_image_path: user.imagePath,
      );
      return await _userService.create(data: userModel);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }
}

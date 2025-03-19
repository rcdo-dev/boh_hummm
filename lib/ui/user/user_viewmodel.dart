import 'package:boh_hummm/data/repositories/user_repository.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';

class UserViewModel {
  final UserRepository _userRepository;

  UserViewModel({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  UserEntity? _userEntity;
  UserEntity? get userEntity => _userEntity;
}

import 'package:boh_hummm/data/repositories/user_repository.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';
import 'package:boh_hummm/utils/command.dart';
import 'package:boh_hummm/utils/result.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  late Command1<void, UserEntity> saveUser;

  UserViewModel({
    required UserRepository userRepository,
  }) : _userRepository = userRepository {
    saveUser = Command1(_saveUser);
  }

  UserEntity? _userEntity;
  UserEntity? get userEntity => _userEntity;

  Future<Result<void>> _saveUser(UserEntity user) async {
    final result = await _userRepository.createUser(user: user);
    notifyListeners();
    switch (result) {
      case Ok<void>():
        return const Result.ok(null);
      case Error<void>():
        return Result.error(result.error);
    }
  }
}

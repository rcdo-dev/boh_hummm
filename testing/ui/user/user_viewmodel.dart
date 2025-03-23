import 'package:boh_hummm/data/repositories/user_repository.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';
import 'package:boh_hummm/utils/command.dart';
import 'package:boh_hummm/utils/result.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  UserViewModel({
    required UserRepository userRepository,
  }) : _userRepository = userRepository {
    saveUser = Command1(_saveUser);
  }

  UserEntity? _userEntity;

  UserEntity? get userEntity => _userEntity;

  late Command1<void, UserEntity> saveUser;

  Future<Result<void>> _saveUser(UserEntity user) async {
    try {
      final result = await _userRepository.createUser(user: user);
      switch (result) {
        case Ok<void>():
          notifyListeners();
          return const Result.ok(null);
        case Error<void>():
          notifyListeners();
          return Result.error(result.error);
      }
    } finally {
      notifyListeners();
    }
  }
}

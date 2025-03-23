import 'package:boh_hummm/data/repositories/user_repository.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  UserViewModel({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  UserEntity? _userEntity;

  UserEntity? get userEntity => _userEntity;
}

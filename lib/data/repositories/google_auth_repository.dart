import 'package:boh_hummm/data/services/google_auth/google_auth_service.dart';
import 'package:boh_hummm/domain/entities/user_entity.dart';
import 'package:boh_hummm/utils/extensions/result_cast.dart';
import 'package:boh_hummm/utils/result.dart';

class GoogleAuthRepository {
  final GoogleAuthService _googleAuthService;

  GoogleAuthRepository({
    required GoogleAuthService googleAuthService,
  }) : _googleAuthService = googleAuthService;

  Future<Result<UserEntity>> logInWithGoogle() async {
    try {
      var result = await _googleAuthService.signInWithGoogle();
      var userCredential = result.asOk.value;
      var userEntity = UserEntity(
        name: userCredential?.user?.displayName,
        email: userCredential?.user?.email,
        imagePath: userCredential?.user?.photoURL,
      );
      return Result.ok(userEntity);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }

  Future<Result<void>> logOutGoogleAccount() async {
    try {
      await _googleAuthService.signOut();
      return const Result.ok(null);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }
}

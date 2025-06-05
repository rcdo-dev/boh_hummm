import 'package:boh_hummm/utils/result.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  GoogleAuthService(
    this._auth,
    this._googleSignIn,
  );

  /// Retorna o usuário atual logado (ou null se não estiver logado).
  User? get currentUser => _auth.currentUser;

  /// Faz login com conta Google e autentica no Firebase.
  Future<Result<UserCredential?>> signInWithGoogle() async {
    try {
      // Solicita ao usuário selecionar uma conta Google.
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Result.error(Exception('O usuário cancelou.'));
      }

      // Obtém os detalhes de autenticação da conta selecionada.
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Cria credencial do Firebase com os tokens do Google.
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return Result.ok(
        // Faz login no Firebase com essa credencial.
        await _auth.signInWithCredential(credential),
      );
    } on Exception catch (e, s) {
      Result.error(e, s);
    }
    return Result.error(Exception('Authentication with Google login failed.'));
  }

  /// Faz logout tanto do Firebase quanto do Google.
  Future<Result<void>> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      return const Result.ok(null);
    } on Exception catch (e, s) {
      return Result.error(e, s);
    }
  }
}

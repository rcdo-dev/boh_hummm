import 'package:boh_hummm/utils/extensions/result_cast.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

import '../../../../testing/data/services/google_auth/google_auth.dart';
import 'generate_mocks_google_auth.mocks.dart';

class FakeUserCredential extends Fake implements UserCredential {}

void main() {
  late GoogleAuthService googleAuth;

  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;

  late MockGoogleSignInAccount mockGoogleSignInAccount;
  late MockGoogleSignInAuthentication mockGoogleSignInAuthentication;

  late FakeUserCredential fakeUserCredential;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();

    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();

    fakeUserCredential = FakeUserCredential();

    googleAuth = GoogleAuthService(
      mockFirebaseAuth,
      mockGoogleSignIn,
    );
  });

  test('signInWithGoogle returns UserCredential on success', () async {
    when(mockGoogleSignIn.signIn()).thenAnswer(
      (_) async => mockGoogleSignInAccount,
    );
    when(mockGoogleSignInAccount.authentication).thenAnswer(
      (_) async => mockGoogleSignInAuthentication,
    );

    when(mockGoogleSignInAuthentication.accessToken).thenReturn('access-token');
    when(mockGoogleSignInAuthentication.idToken).thenReturn('id-token');

    when(mockFirebaseAuth.signInWithCredential(any)).thenAnswer(
      (_) async => fakeUserCredential,
    );

    final result = await googleAuth.signInWithGoogle();

    expect(result.asOk.value, isA<FakeUserCredential>());
    verify(mockGoogleSignIn.signIn()).called(1);
    verify(mockFirebaseAuth.signInWithCredential(any)).called(1);
  });

  test('signInWithGoogle returns null if user cancels login', () async {
    when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

    final result = await googleAuth.signInWithGoogle();

    expect(result.asError.error, isA<Exception>());
    verifyNever(mockFirebaseAuth.signInWithCredential(any));
  });
}

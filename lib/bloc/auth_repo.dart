import 'package:akkelny3/bloc/authbloc_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final _auth = FirebaseAuth.instance;

  Future<AuthblocState> googleSign() async {
    AuthblocState _authState = AuthblocInitial();
    try {
      final googleSign = GoogleSignIn();
      final googleAccount = await googleSign.signIn();
      print(googleAccount.displayName);
      if (googleAccount == null) {
        return AuthErrorState("Canceled By User");
      }
      final googleSignIn = await googleAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignIn.idToken, accessToken: googleSignIn.accessToken);
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User user = authResult.user;
      _authState = SignedInState(user);
    } catch (e) {
      print("Error : ${e.toString()}");
      _authState = AuthErrorState('Erro While Trying to log in');
    }
    return _authState;
  }
}

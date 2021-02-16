import 'dart:async';

import 'package:akkelny3/bloc/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authbloc_event.dart';
part 'authbloc_state.dart';

class AuthBloc extends Bloc<AuthblocEvent, AuthblocState> {
  AuthBloc(this._authRepo) : super(AuthblocInitial());

  AuthRepo _authRepo;

  @override
  Stream<AuthblocState> mapEventToState(
    AuthblocEvent event,
  ) async* {
    if (event is SwitchToSignInEvent) {
      yield SignInState();
    } else if (event is SwitchToSignUpEvent) {
      yield SwitchToSignUp();
    } else if (event is GoogleSignInEvent) {
      yield AuthLoadingState();
      yield await _authRepo.googleSign();
    }
  }
}

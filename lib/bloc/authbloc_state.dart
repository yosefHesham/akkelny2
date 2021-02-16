part of 'authbloc_bloc.dart';

@immutable
abstract class AuthblocState {}

class AuthblocInitial extends AuthblocState {}

class SwitchToSignUp extends AuthblocState {}

class SignInState extends AuthblocState {}

class AuthLoadingState extends AuthblocState {}

class SignedOutState extends AuthblocState {}

class SignedInState extends AuthblocState {
  final User user;
  SignedInState(this.user);
}

class AuthErrorState extends AuthblocState {
  final errorMsg;
  AuthErrorState(this.errorMsg);
}

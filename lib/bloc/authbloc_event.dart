part of 'authbloc_bloc.dart';

@immutable
abstract class AuthblocEvent {}

class SwitchToSignInEvent extends AuthblocEvent {}

class SwitchToSignUpEvent extends AuthblocEvent {}

class GoogleSignInEvent extends AuthblocEvent {}

class SignOutEvent extends AuthblocEvent {}

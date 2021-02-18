part of 'authbloc_bloc.dart';

@immutable
abstract class AuthblocEvent {}

class SwitchToSignInEvent extends AuthblocEvent {}

class SwitchToSignUpEvent extends AuthblocEvent {}

class GoogleSignInEvent extends AuthblocEvent {}

class SignOutEvent extends AuthblocEvent {}

class SignUpEvent extends AuthblocEvent {
  final name;
  final email;
  final password;
  SignUpEvent(
      {@required this.name, @required this.email, @required this.password});
}

class SignInEvent extends AuthblocEvent {
  final email;
  final password;
  SignInEvent({@required this.email, @required this.password});
}

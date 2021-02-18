part of 'form_bloc.dart';

@immutable
abstract class FormEvent {}

class SubmitFormEvent extends FormEvent {
  final bool isSignUp;
  SubmitFormEvent(this.isSignUp);
}

part of 'form_bloc.dart';

@immutable
abstract class FormValidate {}

class FormInitial extends FormValidate {}

class SubmitFormState extends FormValidate {
  final bool isSignup;
  SubmitFormState(this.isSignup);
}

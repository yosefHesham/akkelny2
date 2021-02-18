import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormValidate> {
  FormBloc() : super(FormInitial());

  @override
  Stream<FormValidate> mapEventToState(
    FormEvent event,
  ) async* {
    if (event is SubmitFormEvent) {
      yield SubmitFormState(event.isSignUp);
    }
  }
}

import 'dart:async';

import 'package:demo_bloc/data/models/email.dart';
import 'package:demo_bloc/data/models/password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
part 'form_event.dart';
part 'form_state.dart';

class FormBloC extends Bloc<FormEvent, DemoFormState> {
  FormBloC() : super(const DemoFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<DemoFormState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email.invalid ? email : Email.pure(event.email),
        status: Formz.validate([email, state.password])));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<DemoFormState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password.invalid ? password : Password.pure(event.password),
        status: Formz.validate([state.email, password])));
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<DemoFormState> emit) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void _onPasswordUnfocused(
    PasswordUnfocused event,
    Emitter<DemoFormState> emit,
  ) {
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<DemoFormState> emit) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password]),
    ));
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }
  }
  // void _onFormSubmitted(
  //     FormSubmitted event, Emitter<DemoFormState> emit) async {
  //   final email = Email.dirty(state.email.value);
  //   final password = Password.dirty(state.password.value);
  //   emit(state.copyWith(
  //       email: email,
  //       password: password,
  //       status: Formz.validate([email, password])));
  //   if (state.status.isValidated) {
  //     emit(state.copyWith(status: FormzStatus.submissionInProgress));

  //     await Future<void>.delayed(const Duration(seconds: 1));

  //     emit(state.copyWith(status: FormzStatus.submissionSuccess));
  //   }
  // }
}

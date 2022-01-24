part of 'form_bloc.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

//Each class is an event!
class EmailChanged extends FormEvent {
  final email;

  EmailChanged({required this.email});

  @override
  List<Email> get props => [email];
}

class PasswordChanged extends FormEvent {
  final password;

  PasswordChanged({required this.password});

  @override
  List<Email> get props => [password];
}

class EmailUnfocused extends FormEvent {}

class PasswordUnfocused extends FormEvent {}

class FormSubmitted extends FormEvent {}

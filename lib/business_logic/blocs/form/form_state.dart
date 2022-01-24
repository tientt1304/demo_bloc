part of 'form_bloc.dart';

class DemoFormState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;

  const DemoFormState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});

  //copyWith dont mutate the original object
  DemoFormState copyWith(
      {Email? email, Password? password, FormzStatus? status}) {
    return DemoFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [email, password, status];
}

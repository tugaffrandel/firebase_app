// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authbloc_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpUser extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpUser({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LogInUser extends AuthEvent {
  final String email;
  final String password;

  const LogInUser({required this.email, required this.password});
}

class SignOutUser extends AuthEvent {}

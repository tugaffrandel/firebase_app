part of 'authbloc_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthblocInitial extends AuthState {}

final class AuthenticationLoadingState extends AuthState {
  final bool isLoading;

  const AuthenticationLoadingState({required this.isLoading});
}

class AuthenticationSuccessState extends AuthState {
  final UserModel user;

  const AuthenticationSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

class AuthenticationFailureState extends AuthState {
  final String errorMessage;

  const AuthenticationFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_firebase_login/models/user.dart';
import 'package:todo_app_firebase_login/services/user_auth/firebase_auth.dart';

part 'authbloc_event.dart';
part 'authbloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices authService = AuthServices();

  AuthBloc() : super(AuthblocInitial()) {
    on<SignUpUser>(_signUpUser);
    on<LogInUser>(_logInUser);
    on<SignOutUser>(_signOutUser);
  }
  Future<void> _signUpUser(SignUpUser event, Emitter<AuthState> emit) async {
    emit(const AuthenticationLoadingState(isLoading: true));
    try {
      final UserModel? user = await authService.signUpUser(
        event.name,
        event.email,
        event.password,
      );
      if (user != null) {
        emit(AuthenticationSuccessState(user));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthenticationFailureState('Password Provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthenticationFailureState('Email Provided already Exists'));
      }
    } catch (e) {
      emit(AuthenticationFailureState(e.toString()));
    }
    emit(const AuthenticationLoadingState(isLoading: false));
  }

  Future<void> _logInUser(LogInUser event, Emitter<AuthState> emit) async {
    emit(const AuthenticationLoadingState(isLoading: true));
    try {
      final UserModel? user =
          await authService.signInUser(event.email, event.password);
      if (user != null) {
        emit(AuthenticationSuccessState(user));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const AuthenticationFailureState('No User found with this Email'));
      } else if (e.code == 'wrong-password') {
        emit(const AuthenticationFailureState('Password did not match'));
      }
    }
    emit(const AuthenticationLoadingState(isLoading: false));
  }

  Future<void> _signOutUser(SignOutUser event, Emitter<AuthState> emit) async {
    emit(const AuthenticationLoadingState(isLoading: true));

    try {
      authService.signOut();
    } catch (e) {
      print(e.toString());
    }
    emit(const AuthenticationLoadingState(isLoading: false));
  }
}

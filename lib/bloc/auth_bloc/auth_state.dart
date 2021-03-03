part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadProgress extends AuthState {}

class AuthLoadSuccess extends AuthState {
  final User user;

  AuthLoadSuccess({this.user}) : assert(user != null);

  List<Object> get props => [user];
}

class AuthFailure extends AuthState {}

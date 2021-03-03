part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class UserRequested extends AuthEvent {
  final String portal;
  final String login;
  final String password;

  const UserRequested(
      {@required this.portal, @required this.login, @required this.password})
      : assert(login != null, password != null);

  @override
  List<Object> get props => [portal, login, password];
}

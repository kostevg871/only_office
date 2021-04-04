part of 'my_user_bloc.dart';

abstract class MyUserState extends Equatable {
  const MyUserState();
  @override
  List<Object> get props => [];
}

class MyUserInitial extends MyUserState {}

class MyUserLoading extends MyUserState {}

class MyUserSuccess extends MyUserState {
  final User user;
  const MyUserSuccess({this.user}) : assert(user != null);

  @override
  List<Object> get props => [user];
}

class MyUserFailure extends MyUserState {}

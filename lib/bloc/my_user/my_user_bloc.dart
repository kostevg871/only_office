import 'dart:async';

import 'package:auth_app/models/user.dart';
import 'package:auth_app/services/user_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'my_user_event.dart';
part 'my_user_state.dart';

class MyUserBloc extends Bloc<MyUserEvent, MyUserState> {
  UsersService usersService;

  MyUserBloc(this.usersService) : super(MyUserInitial());

  @override
  Stream<MyUserState> mapEventToState(
    MyUserEvent event,
  ) async* {
    if (event is FetchEventUser) {
      yield MyUserLoading();
      try {
        final User user = await usersService.getUserInfo();
        yield MyUserSuccess(user: user);
      } catch (e) {
        print(e);
        yield MyUserFailure();
      }
    }
  }
}

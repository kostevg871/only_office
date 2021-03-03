import 'dart:async';

import 'package:auth_app/models/users.dart';
import 'package:auth_app/repository/auth_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final userApiClient = UserApiClient(httpClient: http.Client());
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is UserRequested) {
      yield AuthLoadProgress();
      try {
        final user = await userApiClient.getUser(
            event.portal, event.login, event.password);
        if (user != null) {
          yield AuthLoadSuccess(user: user);
        }
      } catch (_) {
        yield AuthFailure();
      }
    }
  }
}

import 'dart:convert';

import 'package:auth_app/services/auth_service.dart';
import 'package:auth_app/validation/validation_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class FormBloc with ValidationMixin {
  final _portal = new BehaviorSubject<String>();
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _errorMessage = new BehaviorSubject<String>();

  Function(String) get changePortal => _portal.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get addError => _errorMessage.sink.add;

  Stream<String> get portal => _portal.stream.transform(validatorPortal);
  Stream<String> get email => _email.stream.transform(validatorEmail);
  Stream<String> get password => _password.stream.transform(validatorPassword);
  Stream<String> get errorMessage => _errorMessage.stream;

  Stream<bool> get submitValidForm =>
      Rx.combineLatest3(portal, email, password, (po, e, p) => true);

  var authInfo;
  Future<dynamic> login(BuildContext context) async {
    authInfo = AuthService();

    final res =
        await authInfo.getUser(_portal.value, _email.value, _password.value);
    final data = jsonDecode(res) as Map<String, dynamic>;

    if (data['statusCode'] != 201) {
      addError(data['error']['message']);
    } else {
      addError(null);
      print(data["token"]);
      AuthService.setToken(data['token']);
      Navigator.pushNamed(context, "/home");
      return data;
    }
  }

  dispose() {
    _portal.close();
    _email.close();
    _password.close();
    _errorMessage.close();
  }
}

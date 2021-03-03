import 'dart:convert';

import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static final SESSION = FlutterSession();

  Future<dynamic> getUser(String portal, String login, String password) async {
    final baseUrl = 'http://$portal.onlyoffice.com/api/2.0/authentication';

    try {
      var res = await http.post("$baseUrl",
          body: jsonEncode({"userName": "$login", "password": "$password"}),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          });
      print(res.body);
      return res?.body;
    } finally {}
  }

  static setToken(String token) async {
    _AuthData data = _AuthData(token);
    await SESSION.set('tokens', data);
  }

  static Future<Map<String, dynamic>> getToken() async {
    return await SESSION.get('tokens');
  }

  static removeToken() async {
    await SESSION.prefs.clear();
  }
}

class _AuthData {
  String token;

  _AuthData(this.token);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['token'] = token;
    return data;
  }
}

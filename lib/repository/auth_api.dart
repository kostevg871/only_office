import 'dart:convert';

import 'package:auth_app/models/users.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class UserApiClient {
  final http.Client httpClient;
  static final SESSION = FlutterSession();

  UserApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<User> getUser(String portal, String login, String password) async {
    final baseUrl = 'http://$portal.onlyoffice.com/api/2.0/authentication';
    final userResponse = await this.httpClient.post(baseUrl,
        body: jsonEncode({"userName": "$login", "password": "$password"}),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json"
        });
    if (userResponse.statusCode == 201) {
      print(userResponse.body);
      final userJson = jsonDecode(userResponse.body);
      setToken(userJson['token']);
      return User.fromMap(userJson);
    } else {
      print("err: ${userResponse.statusCode}");
    }
  }

  Future<User> getDocuments(User user, String portal) async {
    final userToken = user.token;
    final baseUrl = 'http://$portal.onlyoffice.com/api/2.0/files/@my';
    final userResponse =
        await this.httpClient.get(baseUrl, headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": ""
    });
    if (userResponse.statusCode == 201) {
      print(userResponse.body);
      final userJson = jsonDecode(userResponse.body);
      return userJson;
    } else {
      print("err: ${userResponse.statusCode}");
    }
  }

  static setToken(String token) async {
    _AuthData data = _AuthData(token);
    return await SESSION.set("tokens", data);
  }

  static getToken() async {
    return await SESSION.get("tokens");
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

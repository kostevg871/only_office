import 'dart:convert';

import 'package:auth_app/models/user.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class UsersService {
  static final SESSION = FlutterSession();

  Future<User> getUserInfo() async {
    dynamic token = await FlutterSession().get("tokens");
    dynamic portal = await FlutterSession().get("portals");

    final baseUrl =
        'http://${portal["portal"]}.onlyoffice.com/api/2.0/people/@self';
    var response = await http.get(baseUrl, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '${token["token"]}'
    });
    if (response.statusCode == 200) {
      final responseUser = jsonDecode(response.body);
      final User data = User.fromJson(responseUser);
      return data;
    } else {
      print("err");
    }
  }
}

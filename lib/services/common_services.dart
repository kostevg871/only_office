import 'dart:convert';

import 'package:auth_app/models/documents.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;

class CommonService {
  static final SESSION = FlutterSession();

  Future<Documents> getCommonFile() async {
    dynamic token = await FlutterSession().get("tokens");
    dynamic portal = await FlutterSession().get("portals");

    final baseUrl =
        'http://${portal["portal"]}.onlyoffice.com/api/2.0/files/@common';
    var response = await http.get(baseUrl, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '${token["token"]}'
    });

    if (response.statusCode == 200) {
      final responseDoc = jsonDecode(response.body);
      print(responseDoc);
      final Documents data = Documents.fromJson(responseDoc);
      print(data);
      return data;
    } else {
      final responseDocuments = jsonDecode(response.body);
      print("${responseDocuments["error"]['message']}");
    }
  }
}

import 'package:auth_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/login');
            AuthService.removeToken();
          },
          child: Text("Log Out"),
        ),
      ),
    );
  }
}

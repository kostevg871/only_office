import 'package:flutter/material.dart';

class AuthTextFieldFormPortalAndLogin extends StatefulWidget {
  final String labelText;

  const AuthTextFieldFormPortalAndLogin({
    @required this.labelText,
    @required TextEditingController textController,
  }) : _textController = textController;

  final TextEditingController _textController;

  @override
  _AuthTextFieldFormPortalAndLoginState createState() =>
      _AuthTextFieldFormPortalAndLoginState();
}

class _AuthTextFieldFormPortalAndLoginState
    extends State<AuthTextFieldFormPortalAndLogin> {
  String _passwordError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
          child: TextFormField(
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
            validator: (String value) {
              if (value.length < 3) {
                return "Enter form min 3 char";
              } else {
                return null;
              }
            },
            controller: widget._textController,
            decoration: InputDecoration(
              errorText: _passwordError,
              contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
              labelText: widget.labelText,
              labelStyle:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
              hintText: 'Input text',
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ),
    );
  }
}

class AuthTextFieldFormPassword extends StatefulWidget {
  final String labelText;

  AuthTextFieldFormPassword({
    @required this.labelText,
    @required TextEditingController textController,
  }) : _textController = textController;

  final TextEditingController _textController;

  @override
  _AuthTextFieldFormPasswordState createState() =>
      _AuthTextFieldFormPasswordState();
}

class _AuthTextFieldFormPasswordState extends State<AuthTextFieldFormPassword> {
  bool _secureText = true;
  String _passwordError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
          child: TextFormField(
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
            controller: widget._textController,
            obscureText: _secureText,
            validator: (String value) {
              if (value.length < 5) {
                return "Enter password min 5 char";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
              errorText: _passwordError,
              suffixIcon: IconButton(
                icon: Icon(_secureText
                    ? Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined),
                onPressed: () {
                  setState(() {
                    _secureText = !_secureText;
                  });
                },
              ),
              labelText: widget.labelText,
              labelStyle:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
              hintText: 'Input text',
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ),
    );
  }
}

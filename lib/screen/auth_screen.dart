import 'package:auth_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app/bloc/form_bloc.dart';
import 'package:auth_app/provider/form_provider.dart';
import 'package:auth_app/validation/helper.dart';
import 'package:auth_app/widget/auth_screen_widget/auth_text_field_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  TextEditingController _portalController = TextEditingController();

  TextEditingController _loginController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  var _formKeyPassword = GlobalKey<FormState>();
  var _formKeyPortal = GlobalKey<FormState>();
  var _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                child: Text(
                  "Connect to ONLYOFFICE",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: _formKeyPortal,
                child: AuthTextFieldFormPortalAndLogin(
                  labelText: "Portal",
                  textController: _portalController,
                ),
              ),
              Form(
                key: _formKeyLogin,
                child: AuthTextFieldFormPortalAndLogin(
                  labelText: "Login",
                  textController: _loginController,
                ),
              ),
              Form(
                key: _formKeyPassword,
                child: AuthTextFieldFormPassword(
                  labelText: "Password",
                  textController: _passwordController,
                ),
              ),
              Center(
                child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (BuildContext context, state) {
                  if (state is AuthInitial) {
                    return Text("Input Portal, Login, Password");
                  }
                  if (state is AuthLoadSuccess) {
                    Navigator.pushNamed(context, "/home");
                  }
                  if (state is AuthLoadProgress) {
                    return CircularProgressIndicator();
                  }
                  if (state is AuthFailure) {
                    return Text("Error passwor or login");
                  }
                }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
                child: Container(
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      final portal = _portalController.value.text;
                      final login = _loginController.value.text;
                      final password = _passwordController.value.text;
                      _formKeyPassword.currentState.validate();
                      _formKeyLogin.currentState.validate();
                      _formKeyPortal.currentState.validate();
                      if (_formKeyPassword.currentState.validate() &&
                          _formKeyLogin.currentState.validate() &&
                          _formKeyPortal.currentState.validate()) {
                        print("$portal,$login,$password");
                        BlocProvider.of<AuthBloc>(context).add(UserRequested(
                            login: login, password: password, portal: portal));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FormBloc formBloc = FormProvider.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            child: Column(
              children: [
                _hello(),
                _portalField(formBloc),
                _emailField(formBloc),
                _passwordField(formBloc),
                Container(
                  width: 300,
                  height: 35,
                  child: Helper().errorMessage(formBloc),
                ),
                _button(formBloc),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _portalField(FormBloc formBloc) {
    return StreamBuilder<String>(
      stream: formBloc.portal,
      builder: (context, snapshot) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
            labelText: "Portal",
            labelStyle:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
            hintText: 'Input text',
            hintStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
            errorText: snapshot.error,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onChanged: formBloc.changePortal,
        ),
      ),
    );
  }

  _emailField(FormBloc formBloc) {
    return StreamBuilder<String>(
      stream: formBloc.email,
      builder: (context, snapshot) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
            labelText: "Login",
            labelStyle:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
            hintText: 'Input text',
            hintStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
            errorText: snapshot.error,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onChanged: formBloc.changeEmail,
        ),
      ),
    );
  }

  _passwordField(FormBloc formBloc) {
    return StreamBuilder<String>(
      stream: formBloc.password,
      builder: (context, snapshot) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
            labelText: "Password",
            labelStyle:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
            hintText: 'Input text',
            hintStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
            errorText: snapshot.error,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onChanged: formBloc.changePassword,
        ),
      ),
    );
  }

  _hello() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Text(
        "Connect to ONLYOFFICE",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  _button(formBloc) {
    return StreamBuilder<bool>(
      stream: formBloc.submitValidForm,
      builder: (context, snapshot) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
        child: Container(
          child: RaisedButton(
              color: Colors.blue,
              child: Text(
                "LOGIN",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (snapshot.hasError) {
                  return null;
                }
                return formBloc.login(context);
              }),
        ),
      ),
    );
  }
}

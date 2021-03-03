import 'package:auth_app/bloc/form_bloc.dart';
import 'package:auth_app/provider/form_provider.dart';
import 'package:auth_app/validation/helper.dart';
import 'package:flutter/material.dart';

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
                _progressStatus(formBloc),
                _button(formBloc),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _progressStatus(FormBloc formBloc) {
    return StreamBuilder<bool>(
        stream: formBloc.progressBar,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              width: 300,
              height: 35,
              child: Helper().errorMessage(formBloc),
            );
          }
          if (snapshot.data == true) {
            return CircularProgressIndicator();
          }
          return Text("");
        });
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

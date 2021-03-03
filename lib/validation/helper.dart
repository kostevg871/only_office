import 'package:auth_app/bloc/form_bloc.dart';
import 'package:flutter/material.dart';

class Helper {
  Widget errorMessage(FormBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.errorMessage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data, style: TextStyle(color: Colors.red));
        }
        return Text('');
      },
    );
  }
}

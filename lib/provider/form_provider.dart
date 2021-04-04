import 'package:auth_app/bloc/form_bloc.dart';
import 'package:flutter/material.dart';

class FormProvider extends InheritedWidget {
  final bloc = FormBloc();

  FormProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static FormBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<FormProvider>()
            as FormProvider)
        .bloc;
  }
}

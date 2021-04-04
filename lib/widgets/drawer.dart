import 'package:auth_app/bloc/folders_bloc/folders_bloc.dart';
import 'package:auth_app/bloc/my_user/my_user_bloc.dart';
import 'package:auth_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  // MyUserBloc userBloc;
  FoldersBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<FoldersBloc>(context);

    // userBloc = BlocProvider.of<MyUserBloc>(context);
    // userBloc.add(FetchEventUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // ignore: missing_return
      child: BlocBuilder<MyUserBloc, MyUserState>(builder: (context, state) {
        if (state is MyUserInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MyUserLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MyUserFailure) {
          return Center(
            child: Text("error"),
          );
        } else if (state is MyUserSuccess) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            image:
                                NetworkImage("${state.user.response.avatar}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${state.user.response.firstName} "
                              "${state.user.response.lastName}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${state.user.response.email}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MaterialButton(
                  onPressed: () {
                    setState(() {
                      bloc.add(FetchEvent());
                    });
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/home", (route) => false);
                  },
                  child: Text("My Documents")),
              MaterialButton(
                  onPressed: () {
                    setState(() {
                      bloc.add(FetchEventCommon());
                    });
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/home", (route) => false);
                  },
                  child: Text("Common Documents")),
              MaterialButton(
                onPressed: () {
                  // Navigator.popAndPushNamed(context, '/login');
                  AuthService.removeToken();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/login", (route) => false);
                },
                child: Text("Log out"),
              )
            ],
          );
        }
      }),
    );
  }
}

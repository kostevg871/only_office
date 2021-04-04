import 'package:auth_app/bloc/folders_bloc/folders_bloc.dart';
import 'package:auth_app/bloc/my_user/my_user_bloc.dart';
import 'package:auth_app/models/documents.dart';
import 'package:auth_app/screen/details_screen.dart';
import 'package:auth_app/services/common_services.dart';
import 'package:auth_app/services/folders_service.dart';
import 'package:auth_app/services/user_services.dart';
import 'package:auth_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoldersBloc(FoldersService(), CommonService()),
      child: BlocProvider(
        create: (context) => MyUserBloc(UsersService()),
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Documents"),
          ),
          drawer: HomeDrawer(),
          body: FoldersUi(),
        ),
      ),
    );
  }
}

class FoldersUi extends StatefulWidget {
  @override
  _FoldersUiState createState() => _FoldersUiState();
}

class _FoldersUiState extends State<FoldersUi> {
  FoldersBloc bloc;
  MyUserBloc userBloc;

  @override
  void initState() {
    bloc = BlocProvider.of<FoldersBloc>(context);
    userBloc = BlocProvider.of<MyUserBloc>(context);
    bloc.add(FetchEvent());
    userBloc.add(FetchEventUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoldersBloc, FoldersState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is FoldersInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FoldersLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FoldersFailure) {
          return Center(
            child: Text("Something went wrong"),
          );
        } else if (state is FoldersSuccess) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.documents.response.folders.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              final int indexFolders = index;
                              final String idFolders = state
                                  .documents.response.folders[index].id
                                  .toString();
                              final Documents doc = state.documents;
                              // setState(() {
                              //   bloc.add(FetchIdEvent(idFolders: idFolders));
                              // });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FutureProvider(
                                            create: (context) =>
                                                FoldersService()
                                                    .getFoldersId(idFolders),
                                            child: DetailsScreen(
                                                idFolders, doc, indexFolders),
                                          )));
                            },
                            child: ListTile(
                              leading: Icon(Icons.folder_open),
                              title: Text(state
                                  .documents.response.folders[index].title),
                              subtitle: Text(state
                                  .documents.response.folders[index].created
                                  .toString()
                                  .substring(0, 10)),
                            ),
                          );
                        }),
                  ),
                  Expanded(
                    flex: 0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.documents.response.files.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                state.documents.response.files[index].title),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

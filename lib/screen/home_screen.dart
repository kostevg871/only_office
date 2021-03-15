import 'package:auth_app/bloc/folders_bloc/folders_bloc.dart';
import 'package:auth_app/services/folders_service.dart';
import 'package:auth_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Documents"),
      ),
      drawer: HomeDrawer(),
      body: BlocProvider(
        create: (context) => FoldersBloc(FoldersService()),
        child: FoldersUi(),
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

  @override
  void initState() {
    bloc = BlocProvider.of<FoldersBloc>(context);
    bloc.add(FetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoldersBloc, FoldersState>(
      builder: (context, state) {
        if (state is FoldersInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FoldersLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FoldersFailure) {
          return Center(
            child: Text("error"),
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
                          return ListTile(
                            leading: Icon(Icons.folder_open),
                            title: Text(
                                state.documents.response.folders[index].title),
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

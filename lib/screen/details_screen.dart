import 'package:auth_app/models/documents.dart';
import 'package:auth_app/services/folders_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  final String idFolders;
  final Documents documents;
  final int indexFolders;

  DetailsScreen(this.idFolders, this.documents, this.indexFolders);

  @override
  Widget build(BuildContext context) {
    Documents folderId = Provider.of<Documents>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("${documents.response.folders[indexFolders].title}"),
      ),
      body: Column(
        children: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back"),
          ),
          (folderId == null)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: folderId.response.folders.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                final int indexFolders = index;
                                final String idFolders = folderId
                                    .response.folders[index].id
                                    .toString();
                                final Documents doc = folderId;
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
                                title: Text(
                                    folderId.response.folders[index].title),
                                subtitle: Text(folderId
                                    .response.folders[index].created
                                    .toString()
                                    .substring(0, 10)),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: folderId.response.files.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(folderId.response.files[index].title),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}

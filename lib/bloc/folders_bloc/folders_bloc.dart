import 'dart:async';

import 'package:auth_app/models/documents.dart';
import 'package:auth_app/services/common_services.dart';
import 'package:auth_app/services/folders_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'folders_event.dart';
part 'folders_state.dart';

class FoldersBloc extends Bloc<FoldersEvent, FoldersState> {
  FoldersService foldersService;
  CommonService commonService;

  FoldersBloc(this.foldersService, this.commonService)
      : super(FoldersInitial());

  @override
  Stream<FoldersState> mapEventToState(
    FoldersEvent event,
  ) async* {
    if (event is FetchEvent) {
      yield FoldersLoading();
      try {
        final Documents documents = await foldersService.getFolders();
        yield FoldersSuccess(documents: documents);
      } catch (e) {
        print(e);
        yield FoldersFailure();
      }
    }
    if (event is FetchEventCommon) {
      yield FoldersLoading();
      try {
        final Documents documents = await commonService.getCommonFile();
        yield FoldersSuccess(documents: documents);
      } catch (e) {
        yield FoldersFailure();
      }
    }
    if (event is FetchIdEvent) {
      yield FoldersInitial();
      try {
        final Documents documents =
            await foldersService.getFoldersId(event.idFolders);
        yield FoldersSuccess(documents: documents);
      } catch (e) {
        yield FoldersFailure();
      }
    }
  }
}

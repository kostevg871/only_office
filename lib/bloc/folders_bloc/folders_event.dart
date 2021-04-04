part of 'folders_bloc.dart';

@immutable
abstract class FoldersEvent extends Equatable {
  const FoldersEvent();
  @override
  List<Object> get props => [];
}

class FetchEvent extends FoldersEvent {}

class FetchEventCommon extends FoldersEvent {}

class FetchIdEvent extends FoldersEvent {
  final String idFolders;
  FetchIdEvent({@required this.idFolders});

  @override
  List<Object> get props => [idFolders];
}

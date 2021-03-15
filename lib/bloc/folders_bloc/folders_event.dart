part of 'folders_bloc.dart';

@immutable
abstract class FoldersEvent extends Equatable {
  const FoldersEvent();
  @override
  List<Object> get props => [];
}

class FetchEvent extends FoldersEvent {}

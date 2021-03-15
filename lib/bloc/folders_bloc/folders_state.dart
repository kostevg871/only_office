part of 'folders_bloc.dart';

@immutable
abstract class FoldersState extends Equatable {
  const FoldersState();
  @override
  List<Object> get props => [];
}

class FoldersInitial extends FoldersState {}

class FoldersLoading extends FoldersState {}

class FoldersSuccess extends FoldersState {
  final Documents documents;
  const FoldersSuccess({this.documents}) : assert(documents != null);

  @override
  List<Object> get props => [documents];
}

class FoldersFailure extends FoldersState {}

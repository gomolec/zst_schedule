part of 'lists_bloc.dart';

abstract class ListsEvent extends Equatable {
  const ListsEvent();

  @override
  List<Object> get props => [];
}

class GetLists extends ListsEvent {
  const GetLists();

  @override
  List<Object> get props => [];
}

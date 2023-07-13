part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetHomeEvent extends HomeEvent {}

class GetSearchHomeEvent extends HomeEvent {
  final String query;

  GetSearchHomeEvent(this.query);
}

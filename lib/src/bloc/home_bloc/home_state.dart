part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class SuccessHomeState extends HomeState {
  final List<ImageModel> model;
  SuccessHomeState(this.model);
}

class FailedHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

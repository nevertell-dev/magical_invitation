part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeEvent {
  final ScrollController controller;

  const HomeStarted(this.controller);

  @override
  List<Object> get props => [controller];
}

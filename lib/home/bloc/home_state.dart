// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final ScrollController scrollController;
  final double maxExtent;
  final List<ScrollAdapter> adapters;

  const HomeLoaded({
    required this.scrollController,
    required this.maxExtent,
    required this.adapters,
  });

  @override
  List<Object> get props => [scrollController, maxExtent, adapters];

  HomeLoaded copyWith({
    ScrollController? scrollController,
    double? maxExtent,
    List<ScrollAdapter>? adapters,
  }) {
    return HomeLoaded(
      scrollController: scrollController ?? this.scrollController,
      maxExtent: maxExtent ?? this.maxExtent,
      adapters: adapters ?? this.adapters,
    );
  }
}

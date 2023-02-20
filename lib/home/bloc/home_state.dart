// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final ScrollController controller;
  final double maxExtent;
  final ScrollAdapter quoteAdapter;
  final ScrollAdapter brideAdapter;
  final ScrollAdapter groomAdapter;

  const HomeLoaded({
    required this.controller,
    required this.maxExtent,
    required this.quoteAdapter,
    required this.brideAdapter,
    required this.groomAdapter,
  });

  @override
  List<Object> get props => [
        maxExtent,
        quoteAdapter,
        brideAdapter,
        groomAdapter,
      ];

  HomeLoaded copyWith({
    ScrollController? controller,
    double? maxExtent,
    ScrollAdapter? quoteAdapter,
    ScrollAdapter? brideAdapter,
    ScrollAdapter? groomAdapter,
  }) {
    return HomeLoaded(
      controller: controller ?? this.controller,
      maxExtent: maxExtent ?? this.maxExtent,
      quoteAdapter: quoteAdapter ?? this.quoteAdapter,
      brideAdapter: brideAdapter ?? this.brideAdapter,
      groomAdapter: groomAdapter ?? this.groomAdapter,
    );
  }
}

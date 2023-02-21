// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'paper_cubit.dart';

abstract class PaperState extends Equatable {
  const PaperState();

  @override
  List<Object> get props => [];
}

class PaperInitial extends PaperState {}

class PaperLoaded extends PaperState {
  final List<ScrollAdapter> adapters;

  const PaperLoaded(this.adapters);

  PaperLoaded copyWith({
    List<ScrollAdapter>? adapters,
  }) {
    return PaperLoaded(
      adapters ?? this.adapters,
    );
  }

  @override
  List<Object> get props => [adapters];
}

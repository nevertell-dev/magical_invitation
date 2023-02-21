// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'potrait_cubit.dart';

abstract class PotraitState extends Equatable {
  const PotraitState();

  @override
  List<Object> get props => [];
}

class PotraitInitial extends PotraitState {}

class PotraitLoaded extends PotraitState {
  final ScrollAdapter imageAdapter;
  final ScrollAdapter textAdapter;

  const PotraitLoaded({
    required this.imageAdapter,
    required this.textAdapter,
  });
}

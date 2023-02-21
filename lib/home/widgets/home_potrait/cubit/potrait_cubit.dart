import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'potrait_state.dart';

class PotraitCubit extends Cubit<PotraitState> {
  PotraitCubit() : super(PotraitInitial());

  potraitStarted(ScrollController controller, double? begin, double? end) {
    emit(PotraitLoaded(
        imageAdapter: ScrollAdapter(controller, begin: begin, end: end),
        textAdapter: ScrollAdapter(controller, begin: begin, end: end)));
  }
}

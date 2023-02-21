import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'paper_state.dart';

class PaperCubit extends Cubit<PaperState> {
  PaperCubit() : super(PaperInitial());

  init(ScrollController controller) => emit(PaperLoaded([
        ScrollAdapter(controller, end: 1000),
        ScrollAdapter(controller, begin: 500, end: 1000),
        ScrollAdapter(controller, begin: 500, end: 1500),
      ]));
}

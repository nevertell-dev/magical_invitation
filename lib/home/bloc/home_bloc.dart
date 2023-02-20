// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeStarted>((event, emit) {
      final maxExtent = event.controller.position.maxScrollExtent;
      emit(HomeLoaded(
        controller: event.controller,
        maxExtent: event.controller.position.maxScrollExtent,
        quoteAdapter: ScrollAdapter(
          event.controller,
          end: maxExtent * 0.2,
        ),
        brideAdapter: ScrollAdapter(
          event.controller,
          end: maxExtent * 0.3,
        ),
        groomAdapter: ScrollAdapter(
          event.controller,
          begin: maxExtent * 0.15,
          end: maxExtent * 0.45,
        ),
      ));
    });
  }

  @override
  Future<void> close() {
    // scrollController.dispose();
    return super.close();
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:defer_pointer/defer_pointer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

typedef ScrollerBuilder = List<Widget> Function(
    BuildContext context, ScrollController controller);

class Scroller extends StatelessWidget {
  const Scroller({
    Key? key,
    required this.controller,
    this.height = 0,
    required this.children,
  }) : super(key: key);

  final ScrollController controller;
  final double height;
  final ScrollerBuilder children;

  @override
  Widget build(BuildContext context) {
    final baseHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ScrollerCubit()..init(),
      child: BlocBuilder<ScrollerCubit, ScrollerState>(
        builder: (context, state) {
          return DeferredPointerHandler(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (state is ScrollerLoaded)
                  ...children.call(context, controller),
                SingleChildScrollView(
                  controller: controller,
                  child: Container(height: baseHeight + height),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ScrollerCubit extends Cubit<ScrollerState> {
  ScrollerCubit() : super(ScrollerInitial());

  final player = AudioPlayer();

  void init() async {
    await player.setAsset('assets/audio/audio.mp3');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      player.play();
      emit(ScrollerLoaded());
    });
  }
}

abstract class ScrollerState extends Equatable {
  const ScrollerState();

  @override
  List<Object?> get props => [];
}

class ScrollerInitial extends ScrollerState {}

class ScrollerLoaded extends ScrollerState {}

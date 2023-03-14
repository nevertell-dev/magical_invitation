// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:defer_pointer/defer_pointer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

typedef TimelineBuilder = List<Widget> Function(
  BuildContext context,
  ScrollController controller,
);

class Timeline extends StatelessWidget {
  const Timeline({
    Key? key,
    required this.controller,
    this.height = 0,
    required this.children,
  }) : super(key: key);

  final ScrollController controller;
  final double height;
  final TimelineBuilder children;

  @override
  Widget build(BuildContext context) {
    final baseHeight = MediaQuery.of(context).size.height;

    onTap(BuildContext context) => context.read<TimelineCubit>().init();

    return BlocProvider(
      create: (context) => TimelineCubit(),
      child: BlocBuilder<TimelineCubit, TimelineState>(
        builder: (context, state) {
          return DeferredPointerHandler(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ...(state is TimelineLoaded
                    ? children.call(context, controller)
                    : [
                        DeferPointer(
                            child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => onTap(context),
                                child: const Text(
                                  'Tap the screen to open the invitation..',
                                  style: TextStyle(
                                    fontFamily: 'Caveat',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )))
                      ]),
                SingleChildScrollView(
                  physics: state is TimelineLoaded
                      ? const AlwaysScrollableScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
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

class TimelineCubit extends Cubit<TimelineState> {
  TimelineCubit() : super(TimelineInitial());

  final player = AudioPlayer();

  void init() async {
    emit(TimelineLoaded());
    await player.setAsset('assets/audio/audio.mp3');
    player.play();
  }
}

abstract class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object?> get props => [];
}

class TimelineInitial extends TimelineState {}

class TimelineLoaded extends TimelineState {}

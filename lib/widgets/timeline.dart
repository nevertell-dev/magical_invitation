// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:defer_pointer/defer_pointer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:magical_invitation/utils/const.dart';

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

    return BlocProvider(
      create: (context) => TimelineCubit(),
      child: BlocBuilder<TimelineCubit, TimelineState>(
        builder: (context, state) {
          return DeferredPointerHandler(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...(state is TimelineLoaded
                      ? children.call(context, controller)
                      : [DeferPointer(child: TimelineLoadingWidget(state))]),
                  SingleChildScrollView(
                    physics: state is TimelineLoaded
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    controller: controller,
                    child: Container(height: baseHeight + height),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TimelineLoadingWidget extends StatelessWidget {
  const TimelineLoadingWidget(this.state, {super.key});

  final TimelineState state;

  onTap(BuildContext context) => context.read<TimelineCubit>().init();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTap(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset('assets/images/welcome.png')
                  .animate(target: state is TimelineLoading ? 1 : 0)
                  .fadeOut()
                  .swap(
                    builder: (_, __) =>
                        Image.asset('assets/images/vinyl_disc.png')
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .rotate(end: 1, duration: 10.seconds),
                  ),
            ),
            const Text(
              'Hi.. Untuk pengalaman yang lebih baik,\npastikan volume handphone mu\ntidak terlalu tinggi atau terlalu rendah.\n\ndibuat oleh:\n@teddyrosganandi.\n',
              textAlign: TextAlign.center,
              style: caveatStyle,
            ).animate(target: state is TimelineLoading ? 1 : 0).fadeOut().swap(
                  builder: (_, __) => const Text(
                    'Memuat, mohon tunggu..',
                    style: caveatStyle,
                  ),
                ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 62, 62),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text('Tap layar untuk memulai',
                  style: caveatStyle.copyWith(
                      color: const Color.fromARGB(255, 255, 255, 255))),
            )
                .animate(target: state is TimelineLoading ? 1 : 0)
                .fadeOut()
                .swap(builder: (_, __) => const SizedBox()),
          ],
        ));
  }
}

class TimelineCubit extends Cubit<TimelineState> {
  TimelineCubit() : super(TimelineInitial());

  final player = AudioPlayer();

  void init() async {
    emit(TimelineLoading());
    await Future.delayed(1.seconds);
    await player.setAsset('assets/audio/audio.mp3');
    player.play();
    emit(TimelineLoaded());
  }
}

abstract class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object?> get props => [];
}

class TimelineInitial extends TimelineState {}

class TimelineLoading extends TimelineState {}

class TimelineLoaded extends TimelineState {}

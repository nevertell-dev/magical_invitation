// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:magical_invitation/utils/controller_helper.dart';
import 'package:magical_invitation/widgets/letter.dart';

abstract class Mail extends StatelessWidget {
  const Mail({
    Key? key,
    required this.controller,
    this.begin,
    this.maxScrollExtent,
    this.margin = const Offset(100, 100),
  }) : super(key: key);

  final ScrollController controller;
  final double? begin;
  final double? maxScrollExtent;
  final Offset margin;
}

class MailBack extends Mail {
  const MailBack({
    super.key,
    required super.controller,
    super.begin,
    super.maxScrollExtent,
    super.margin,
  });

  @override
  Widget build(BuildContext context) {
    const size = Offset(360, 480);

    // adapters
    final end = maxScrollExtent.at(0.2);
    final imageAdapter = ScrollAdapter(controller, begin: begin, end: end);
    final mailAdapter = ScrollAdapter(controller, begin: begin, end: end);

    return BlocProvider(
      create: (_) => MailCubit()..init(context),
      child: BlocBuilder<MailCubit, MailState>(
        builder: (context, state) {
          if (state is MailLoaded) {
            return Center(
              child: SizedBox(
                width: size.dx,
                height: size.dy,
                child: ClipRect(
                  clipper: MailRect(size),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child:
                            Image(image: state.baseBack, fit: BoxFit.fitHeight)
                                .animate(adapter: imageAdapter),
                      ),
                      Positioned.fill(
                        child: Image(image: state.stars, fit: BoxFit.fitHeight)
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .rotate(duration: 80000.ms, end: 1),
                      ),
                      Positioned.fill(
                        child: Image(image: state.stars, fit: BoxFit.fitHeight)
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .scaleXY(begin: 0.8, end: 0.8)
                            .rotate(duration: 160000.ms, begin: -0.5, end: 0.5),
                      ),
                      Positioned.fill(
                          child: Image(
                              image: state.vignette, fit: BoxFit.fitHeight)),
                      // Image(image: stamp, fit: BoxFit.fitHeight),
                      Positioned.fill(
                        child: Image(
                                image: state.flower,
                                fit: BoxFit.fitHeight,
                                height: size.dy * 0.8)
                            .animate()
                            .scaleXY(begin: 0.6, end: 0.6),
                      ),
                    ],
                  ),
                )
                    .animate(adapter: mailAdapter)
                    .rotate(end: -0.25)
                    .flipH(begin: 0, end: 0.5, perspective: 0.3)
                    .swap(
                      builder: (_, __) => MailFront(
                        controller: controller,
                        state: state,
                        margin: margin,
                        begin: end,
                        maxScrollExtent: maxScrollExtent,
                      ),
                    ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class MailFront extends Mail {
  const MailFront({
    super.key,
    required super.controller,
    required this.state,
    super.begin,
    super.maxScrollExtent,
    super.margin,
  });

  final MailLoaded state;

  @override
  Widget build(BuildContext context) {
    // adapters
    final end = maxScrollExtent.at(0.4);
    final headAdapter = ScrollAdapter(controller, begin: begin, end: end);
    final mailAdapter = ScrollAdapter(controller, begin: begin, end: end);

    return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
          Image(image: state.baseFront),
          Positioned.fill(
            top: 150,
            child: AbsorbPointer(
              child: Letter(
                controller: controller,
                begin: end,
                size: const Offset(300, 200),
                maxScrollExtent: maxScrollExtent,
              ),
            ),
          ),
          Image(image: state.body),
          Image(image: state.head)
              .animate(adapter: headAdapter)
              .flipV(alignment: Alignment.topCenter, end: -1, perspective: -1)
        ])
        .animate(adapter: mailAdapter)
        .flipH(begin: -0.5, perspective: 0.2)
        .swap(
          builder: (context, child) => MailLetter(
            controller: controller,
            state: state,
            margin: margin,
            begin: end,
            maxScrollExtent: maxScrollExtent,
          ),
        );
  }
}

class MailLetter extends Mail {
  const MailLetter({
    super.key,
    required super.controller,
    required this.state,
    super.begin,
    super.maxScrollExtent,
    super.margin,
  });

  final MailLoaded state;

  @override
  Widget build(BuildContext context) {
    // adapters
    final end = maxScrollExtent.at(0.6);
    final letterAdapter = ScrollAdapter(controller, begin: begin, end: end);
    final bodyAdapter = ScrollAdapter(controller, begin: begin, end: end);
    final mailAdapter = ScrollAdapter(controller, begin: begin, end: end);

    return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Image(image: state.baseFront),
              Image(image: state.head)
                  .animate()
                  .flipV(alignment: Alignment.topCenter, begin: -1, end: -1),
            ],
          ).animate(adapter: mailAdapter).moveY(end: 200).then().fadeOut(),
          Positioned(
            height: 200 * 3,
            top: 150,
            child: Letter(
              controller: controller,
              begin: end,
              size: const Offset(300, 200),
              maxScrollExtent: maxScrollExtent,
            )
                .animate(adapter: letterAdapter)
                .moveY(end: -200)
                .then()
                .scaleXY(end: 1.2),
          ),
          Image(image: state.body)
              .animate(adapter: bodyAdapter)
              .moveY(end: 200)
              .then()
              .fadeOut(),
        ]);
  }
}

class MailRect extends CustomClipper<Rect> {
  MailRect(this.maxSize);

  final Offset maxSize;

  @override
  Rect getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    return Rect.fromCenter(
      center: center,
      width: maxSize.dx,
      height: maxSize.dy,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}

class MailCubit extends Cubit<MailState> {
  MailCubit() : super(MailInitial());

  // IMAGES
  static const assetPath = 'assets/images';
  // mail back images
  final baseBack = const AssetImage('$assetPath/mail_b_base.png');
  final stars = const AssetImage('$assetPath/mail_b_stars.png');
  final vignette = const AssetImage('$assetPath/mail_b_vignette.png');
  final stamp = const AssetImage('$assetPath/mail_b_stamp.png');
  final flower = const AssetImage('$assetPath/mail_b_flower.png');
  // mail front images
  final baseFront = const AssetImage('$assetPath/mail_f_base.png');
  final body = const AssetImage('$assetPath/mail_f_body.png');
  final head = const AssetImage('$assetPath/mail_f_head.png');

  init(BuildContext context) {
    precacheImage(baseFront, context);
    precacheImage(body, context);
    precacheImage(head, context);

    emit(MailLoaded(
      baseBack: baseBack,
      stars: stars,
      vignette: vignette,
      stamp: stamp,
      flower: flower,
      baseFront: baseFront,
      body: body,
      head: head,
    ));
  }
}

abstract class MailState extends Equatable {
  const MailState();

  @override
  List<Object?> get props => [];
}

class MailInitial extends MailState {}

class MailLoaded extends MailState {
  final AssetImage baseBack;
  final AssetImage stars;
  final AssetImage vignette;
  final AssetImage stamp;
  final AssetImage flower;
  final AssetImage baseFront;
  final AssetImage body;
  final AssetImage head;

  const MailLoaded({
    required this.baseBack,
    required this.stars,
    required this.vignette,
    required this.stamp,
    required this.flower,
    required this.baseFront,
    required this.body,
    required this.head,
  });
}

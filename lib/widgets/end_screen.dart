import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magical_invitation/widgets/timeline_widget.dart';
import 'package:magical_invitation/utils/controller_helper.dart';

import '../utils/const.dart';

class EndScreen extends TimelineWidget {
  const EndScreen(
    super.controller, {
    super.key,
    super.minExtent,
    super.maxExtent,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned.fill(
            child: Image.asset('assets/images/mail_b_base.png',
                fit: BoxFit.fitHeight)),
        Positioned.fill(
          child: Image.asset('assets/images/mail_b_stars.png',
                  fit: BoxFit.fitHeight)
              .animate(onPlay: (controller) => controller.repeat())
              .rotate(duration: 80000.ms, end: 1),
        ),
        Positioned.fill(
          child: Image.asset('assets/images/mail_b_stars.png',
                  fit: BoxFit.fitHeight)
              .animate(onPlay: (controller) => controller.repeat())
              .scaleXY(begin: 0.8, end: 0.8)
              .rotate(duration: 160000.ms, begin: -0.5, end: 0.5),
        ),
        Positioned.fill(
          child: Image.asset(
            'assets/images/mail_b_vignette.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        Text(
          'Thank You.',
          textAlign: TextAlign.center,
          style: caveatStyle.copyWith(color: Colors.white),
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.75, minExtent),
                end: maxExtent.at(1, minExtent),
              ),
            )
            .fadeIn()
            .moveY(begin: -100),
        Positioned(
            bottom: 0,
            child: Text(
              '"You are the stars in our sky."',
              textAlign: TextAlign.center,
              style: caveatStyle.copyWith(color: Colors.white),
            )
                .animate(
                  adapter: ScrollAdapter(
                    controller,
                    begin: maxExtent.at(0.5, minExtent),
                    end: maxExtent.at(0.75, minExtent),
                  ),
                )
                .fadeIn()),
      ],
    )
        .animate(
          adapter: ScrollAdapter(
            controller,
            begin: minExtent,
            end: maxExtent.at(0.5, minExtent),
          ),
        )
        .fadeIn()
        .moveY(begin: size.height + 100);
  }
}

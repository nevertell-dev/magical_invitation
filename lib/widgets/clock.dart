// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magical_invitation/widgets/timeline_widget.dart';

class Clock extends TimelineWidget {
  const Clock(
    super.controller, {
    super.key,
    super.minExtent,
    super.maxExtent,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/clock_base.png'),
        Image.asset('assets/images/clock_planets.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent,
              ),
            )
            .rotate(end: 1),
        Image.asset('assets/images/clock_hand_1.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent,
              ),
            )
            .rotate(end: 2),
        Image.asset('assets/images/clock_hand_2.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent,
              ),
            )
            .rotate(end: 3),
        Image.asset('assets/images/clock_hand_3.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent,
              ),
            )
            .rotate(end: 4),
        Image.asset('assets/images/clock_hand_4.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent,
              ),
            )
            .rotate(end: 5),
        Image.asset('assets/images/clock_hand_5.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent,
              ),
            )
            .rotate(end: 6),
        Image.asset('assets/images/clock_center.png'),
      ],
    )
        .animate(
          adapter: ScrollAdapter(
            controller,
            begin: minExtent,
            end: maxExtent,
          ),
        )
        .moveY(begin: (size.height / 2) + 250, end: -(size.height / 2) - 250);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magical_invitation/utils/controller_helper.dart';
import 'package:magical_invitation/widgets/timeline_widget.dart';

class DecoFrame extends TimelineWidget {
  const DecoFrame(
    super.controller, {
    super.key,
    super.minExtent,
    super.maxExtent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Image.asset('assets/images/deco_01.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent.at(0.3, minExtent),
              ),
            )
            .scaleXY(alignment: Alignment.topLeft, begin: 0.1, end: 0.7)
            .moveX(begin: -50)
            .rotate(alignment: Alignment.bottomLeft, begin: -0.1),
        Image.asset('assets/images/deco_02.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent.at(0.35, minExtent),
              ),
            )
            .scaleXY(alignment: Alignment.centerLeft, begin: 0.1, end: 0.7)
            .moveX(begin: -50)
            .rotate(alignment: Alignment.bottomLeft, begin: -0.1),
        Image.asset('assets/images/deco_03.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent.at(0.4, minExtent),
              ),
            )
            .scaleXY(alignment: Alignment.bottomLeft, begin: 0.1, end: 0.7)
            .moveX(begin: -50)
            .rotate(alignment: Alignment.bottomLeft, begin: -0.1),
      ],
    )
        .animate(
          adapter: ScrollAdapter(
            controller,
            begin: maxExtent.at(0.7, minExtent),
            end: maxExtent.at(0.8, minExtent),
          ),
        )
        .moveX(end: -100);
  }
}

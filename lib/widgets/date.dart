import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magical_invitation/utils/controller_helper.dart';
import 'package:magical_invitation/widgets/timeline_widget.dart';

class DateAnnouncement extends TimelineWidget {
  const DateAnnouncement(
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
        Positioned(
          left: -size.width * 0.5,
          width: size.width,
          child: Image.asset(
            'assets/images/potrait_groom.png',
            fit: BoxFit.fitWidth,
          ),
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent.at(0.2, minExtent),
              ),
            )
            .moveX(begin: -size.width / 2)
            .scaleXY(begin: 0.8),
        Positioned(
          left: size.width / 2,
          width: size.width,
          child: Image.asset(
            'assets/images/potrait_bride.png',
            fit: BoxFit.fitWidth,
          ),
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent.at(0.2, minExtent),
              ),
            )
            .moveX(begin: size.width / 2)
            .scaleXY(begin: 0.8),
        Image.asset('assets/images/date_1.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent.at(0.2, minExtent),
                end: maxExtent.at(0.4, minExtent),
              ),
            )
            .fadeIn()
            .scaleXY(begin: 0.8),
        Image.asset('assets/images/date_2.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.4, minExtent),
                end: maxExtent.at(0.6, minExtent),
              ),
            )
            .fadeIn()
            .scaleXY(begin: 0.8),
        Image.asset('assets/images/date_3.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.6, minExtent),
                end: maxExtent.at(0.8, minExtent),
              ),
            )
            .fadeIn()
            .scaleXY(begin: 0.8),
        Image.asset('assets/images/date_4.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.6, minExtent),
                end: maxExtent.at(0.8, minExtent),
              ),
            )
            .fadeIn()
            .scaleXY(begin: 0.8),
        Positioned(
          width: size.height,
          bottom: 0,
          child: Image.asset(
            'assets/images/date_5.png',
            fit: BoxFit.fitHeight,
          )
              .animate(
                adapter: ScrollAdapter(
                  controller,
                  begin: maxExtent.at(0.8, minExtent),
                  end: maxExtent.at(1, minExtent),
                ),
              )
              .fadeIn()
              .scaleXY(begin: 0.8, alignment: Alignment.bottomCenter),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magical_invitation/widgets/timeline_widget.dart';

import '../utils/const.dart';

class OverlayText extends TimelineWidget {
  const OverlayText(
    super.controller, {
    super.key,
    super.minExtent,
    super.maxExtent,
    required this.text,
    required this.play,
  });

  final String text;
  final bool play;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          'assets/images/arrow.png',
          width: 16.0,
          height: 16.0,
        ),
        const SizedBox(height: 16.0),
        Container(
          color: const Color.fromARGB(144, 255, 255, 255),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: caveatStyle,
          ),
        ),
      ],
    )
        .animate(target: play ? 1 : 0)
        .fadeIn()
        .animate(
          adapter: ScrollAdapter(
            controller,
            begin: minExtent,
            end: maxExtent,
          ),
        )
        .fadeOut();
  }
}

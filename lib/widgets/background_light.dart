import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magical_invitation/widgets/timeline_widget.dart';

class BackgroundLight extends TimelineWidget {
  const BackgroundLight(
    super.controller, {
    super.key,
    super.maxExtent,
    super.minExtent,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/background_light.png',
      fit: BoxFit.fitHeight,
    )
        .animate(delay: 1.seconds)
        .fadeIn(duration: 1.seconds)
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

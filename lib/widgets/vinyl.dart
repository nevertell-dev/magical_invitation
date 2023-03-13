import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Vinyl extends StatelessWidget {
  const Vinyl({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/vinyl_base.png'),
        Image.asset('assets/images/vinyl_disc.png')
            .animate(onPlay: (controller) => controller.repeat())
            .rotate(end: 1, duration: 10.seconds),
        Image.asset('assets/images/vinyl_pipe.png'),
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magical_invitation/utils/const.dart';

import 'package:magical_invitation/widgets/timeline_widget.dart';

class Potrait extends TimelineWidget {
  const Potrait(
    super.controller, {
    super.key,
    super.minExtent,
    required super.maxExtent,
    required this.image,
    required this.name,
    required this.subtitle,
  });

  final String image;
  final String name;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/${image}_back.png')
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent,
              ),
            )
            .moveY(begin: 100),
        Image.asset('assets/images/$image.png'),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                height: 0.7,
                fontFamily: 'PlayfairDisplay',
                fontWeight: FontWeight.w800,
                fontSize: 52,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: caveatStyle,
            ),
          ],
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: minExtent,
                end: maxExtent,
              ),
            )
            .moveY(begin: 300),
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

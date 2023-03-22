// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magical_invitation/utils/const.dart';

import 'package:magical_invitation/utils/controller_helper.dart';
import 'package:magical_invitation/widgets/timeline_widget.dart';

class Letter extends TimelineWidget {
  const Letter(
    super.controller, {
    super.key,
    super.minExtent,
    super.maxExtent,
    this.size = const Offset(300, 200),
  });

  final Offset size;

  // colors
  final primaryColor = const Color.fromARGB(255, 255, 255, 255);
  final secondaryColor = const Color.fromARGB(255, 255, 255, 255);

  final strings = const [
    'To our dearest ones,',
    'We have found\neach other in this world\nand we want to share\nour joy with you.',
    'Her and Him\nare becoming one.'
  ];

  @override
  Widget build(BuildContext context) {
    final adapters = [
      ScrollAdapter(controller,
          begin: minExtent, end: maxExtent.at(0.3, minExtent)),
      ScrollAdapter(controller,
          begin: maxExtent.at(0.3, minExtent),
          end: maxExtent.at(0.6, minExtent)),
      ScrollAdapter(controller,
          begin: maxExtent.at(0.6, minExtent),
          end: maxExtent.at(0.75, minExtent)),
      ScrollAdapter(controller,
          begin: maxExtent.at(0.75, minExtent),
          end: maxExtent.at(0.9, minExtent)),
      ScrollAdapter(controller,
          begin: maxExtent.at(0.9, minExtent), end: maxExtent.at(1, minExtent)),
    ];

    return SizedBox(
      width: size.dx,
      height: size.dy * 3,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
              width: size.dx,
              height: size.dy,
              child: LetterPiece(
                string: strings[0], // top text
                color: primaryColor,
              )),
          Positioned(
            width: size.dx,
            height: size.dy,
            top: size.dy * 2,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                LetterPiece(color: secondaryColor)
                    .animate(adapter: adapters[0])
                    .flipV(
                        begin: -1,
                        end: -0.5,
                        alignment: Alignment.topCenter,
                        perspective: 0.1)
                    .swap(
                      builder: (context, child) => Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          LetterPiece(
                            string: strings[1], // middle text
                            color: secondaryColor,
                          ),
                          Positioned(
                            width: size.dx,
                            height: size.dy,
                            top: size.dy,
                            child: LetterPiece(
                              color: primaryColor,
                            )
                                .animate(adapter: adapters[2])
                                .flipV(
                                    begin: -1,
                                    end: -0.5,
                                    alignment: Alignment.topCenter,
                                    perspective: 0.1)
                                .swap(
                                  builder: (context, child) => LetterPiece(
                                    string: strings[2], // bottom text
                                    color: primaryColor,
                                  ).animate(adapter: adapters[3]).flipV(
                                      begin: -0.5,
                                      alignment: Alignment.topCenter,
                                      perspective: 0.1),
                                ),
                          ),
                        ],
                      ).animate(adapter: adapters[1]).flipV(
                            begin: -0.5,
                            alignment: Alignment.topCenter,
                            perspective: 0.1,
                          ),
                    ),
              ],
            ),
          ),
        ],
      ),
    ).animate(adapter: adapters[4]).fadeOut();
  }
}

class LetterPiece extends StatelessWidget {
  const LetterPiece({
    Key? key,
    required this.color,
    this.size = const Offset(400, 300),
    this.string = '',
  }) : super(key: key);

  final Color color;
  final Offset size;
  final String string;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.dx,
      height: size.dy,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: color,
          width: 0.0,
        ),
      ),
      child: Center(
          child: Text(
        string,
        textAlign: TextAlign.center,
        style: caveatStyle,
      )),
    );
  }
}

/*
To our dearest ones,
We have found each other in this world
and we want to share our joy with you
Lena and Jake
are becoming one
*/
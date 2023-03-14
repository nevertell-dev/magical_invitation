// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

  @override
  Widget build(BuildContext context) {
    final adapters = [
      ScrollAdapter(controller,
          begin: minExtent, end: maxExtent.at(0.4, minExtent)),
      ScrollAdapter(controller,
          begin: maxExtent.at(0.4, minExtent),
          end: maxExtent.at(0.6, minExtent)),
      ScrollAdapter(controller,
          begin: maxExtent.at(0.6, minExtent),
          end: maxExtent.at(0.8, minExtent)),
    ];

    return SizedBox(
      width: size.dx,
      height: size.dy * 3,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // top
          Positioned(
              width: size.dx,
              height: size.dy,
              child: LetterPiece(string: '', color: primaryColor)),
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
                          // middle
                          LetterPiece(
                            string: 'Her & Him\nWedding',
                            color: secondaryColor,
                          ),
                          // bottom
                          Positioned(
                            width: size.dx,
                            height: size.dy,
                            top: size.dy,
                            child: LetterPiece(
                              string: '',
                              color: primaryColor,
                            ).animate(adapter: adapters[2]).flipV(
                                begin: -1,
                                alignment: Alignment.topCenter,
                                perspective: 0.1),
                          )
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
    );
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
        style: const TextStyle(
          fontFamily: 'Caveat',
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      )),
    );
  }
}

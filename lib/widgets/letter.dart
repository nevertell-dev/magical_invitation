// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:magical_invitation/utils/controller_helper.dart';

class Letter extends StatelessWidget {
  const Letter({
    Key? key,
    required this.controller,
    this.begin,
    this.maxScrollExtent,
    this.size = const Offset(300, 200),
  }) : super(key: key);

  final ScrollController controller;
  final double? begin;
  final double? maxScrollExtent;
  final Offset size;

  // colors
  final primaryColor = const Color.fromARGB(255, 201, 216, 226);
  final secondaryColor = const Color.fromARGB(255, 211, 223, 223);

  @override
  Widget build(BuildContext context) {
    final adapters = [
      ScrollAdapter(controller,
          begin: begin, end: maxScrollExtent.at(0.2, begin)),
      ScrollAdapter(controller,
          begin: maxScrollExtent.at(0.2, begin),
          end: maxScrollExtent.at(0.4, begin)),
      ScrollAdapter(controller,
          begin: maxScrollExtent.at(0.4, begin),
          end: maxScrollExtent.at(0.6, begin)),
    ];

    return SizedBox(
      width: size.dx,
      height: size.dy * 3,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
              width: size.dx,
              height: size.dy,
              child: LetterPiece(string: '1', color: primaryColor)),
          Positioned(
            width: size.dx,
            height: size.dy,
            top: size.dy,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                LetterPiece(color: secondaryColor)
                    .animate(adapter: adapters[0])
                    .flipV(
                        begin: -1,
                        end: -0.5,
                        alignment: Alignment.topCenter,
                        perspective: 0.2)
                    .swap(
                      builder: (context, child) => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          LetterPiece(
                            string: '2',
                            color: secondaryColor,
                          ),
                          Positioned(
                            width: size.dx,
                            height: size.dy,
                            top: size.dy,
                            child: LetterPiece(
                              string: '3',
                              color: primaryColor,
                            ).animate(adapter: adapters[2]).flipV(
                                begin: -1,
                                alignment: Alignment.topCenter,
                                perspective: 0.2),
                          )
                        ],
                      ).animate(adapter: adapters[1]).flipV(
                            begin: -0.5,
                            alignment: Alignment.topCenter,
                            perspective: 0.2,
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
    this.string = 'none',
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
      child: const Center(child: Text('Sample Text')),
    );
  }
}
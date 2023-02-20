// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GreetingPaper extends StatelessWidget {
  const GreetingPaper({
    Key? key,
    required this.width,
    required this.height,
    required this.duration,
  }) : super(key: key);

  final double width;
  final double height;
  final double duration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height * 3,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            width: width,
            height: height,
            child: Container(color: Colors.amber),
          ),
          Positioned(
            width: width,
            height: height,
            top: height,
            child: Container(color: Colors.teal)
                .animate()
                .flipV(
                  alignment: Alignment.topCenter,
                  duration: duration.ms,
                  begin: -1,
                  end: -0.5,
                )
                .then()
                .swap(builder: (context, child) {
              return Container(
                width: width,
                color: Colors.teal,
                child: const Center(
                  child: Text('Text', textAlign: TextAlign.center),
                ),
              );
            }),
          ),
          Positioned(
            width: width,
            height: height,
            top: height,
            child: Container(color: Colors.grey)
                .animate()
                .flipV(
                  delay: duration.ms,
                  alignment: Alignment.topCenter,
                  duration: duration.ms,
                  begin: -0.5,
                )
                .swap(
              builder: (context, child) {
                return Container(color: Colors.grey).animate().flipV(
                      alignment: Alignment.bottomCenter,
                      duration: (duration * 2).ms,
                      end: 1,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}

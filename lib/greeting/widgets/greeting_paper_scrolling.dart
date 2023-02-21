// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/paper_cubit.dart';

class GreetingPaperScrolling extends StatelessWidget {
  const GreetingPaperScrolling({
    Key? key,
    required this.scrollController,
    required this.width,
    required this.height,
  }) : super(key: key);

  final ScrollController scrollController;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaperCubit()..init(scrollController),
      child: SizedBox(
        width: width,
        height: height * 3,
        child: BlocBuilder<PaperCubit, PaperState>(
          builder: (context, state) {
            if (state is PaperLoaded) {
              return Stack(
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
                          .animate(adapter: state.adapters[0])
                          .flipV(
                            alignment: Alignment.topCenter,
                            begin: -1,
                          )),
                  Positioned(
                      width: width,
                      height: height,
                      top: height,
                      child: Container(color: Colors.grey)
                          .animate(adapter: state.adapters[1])
                          .flipV(
                            alignment: Alignment.topCenter,
                            begin: -0.5,
                            end: 0,
                          )
                          .hide()),
                  Positioned(
                      width: width,
                      height: height,
                      top: height * 2,
                      child: Container(color: Colors.grey)
                          .animate(adapter: state.adapters[2])
                          .show()
                          .then()
                          .flipV(
                            alignment: Alignment.topCenter,
                            begin: -1,
                          )),
                  // Positioned(
                  //     width: width,
                  //     height: height,
                  //     top: height * 2,
                  //     child: Container(color: Colors.grey)
                  //         .animate(adapter: state.adapters[2])
                  //         .flipV(
                  //           alignment: Alignment.topCenter,
                  //           begin: -1,
                  //         )),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

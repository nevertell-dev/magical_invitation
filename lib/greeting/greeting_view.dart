import 'package:flutter/material.dart';
import 'package:magical_invitation/greeting/widgets/greeting_paper.dart';
import 'package:magical_invitation/greeting/widgets/greeting_paper_scrolling.dart';
import 'package:magical_invitation/widgets/scroll_area.dart';

class GreetingView extends StatelessWidget {
  GreetingView({super.key});

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GreetingPaperScrolling(
            scrollController: _controller, width: 500, height: 200),
        ScrollArea(controller: _controller),
      ],
    );
  }
}

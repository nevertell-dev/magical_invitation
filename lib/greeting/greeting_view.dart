import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:magical_invitation/widgets/scroll_area.dart';

class GreetingView extends StatefulWidget {
  const GreetingView({super.key});

  @override
  State<GreetingView> createState() => _GreetingViewState();
}

class _GreetingViewState extends State<GreetingView> {
  late final ScrollController _controller;
  late final ScrollAdapter _adapter;

  bool _tapped = false;
  bool _open = false;

  @override
  void initState() {
    _controller = ScrollController();
    _adapter = ScrollAdapter(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        ScrollArea(controller: _controller),
        Positioned(
          height: 800,
          width: 400,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              debugPrint('test');
              setState(() {
                _tapped = true;
              });
            },
            child: Image.asset('assets/images/invitation_b.png')
                .animate(
                  target: _tapped ? 1 : 0,
                  onComplete: (controller) async {
                    if (controller.value == 1) {
                      await Future.delayed(500.ms);
                      setState(() {
                        _open = true;
                      });
                    }
                  },
                )
                .flipH(duration: 500.ms, begin: 0, end: 0.5)
                .swap(
                    builder: (_, __) => Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Image.asset('assets/images/invitation_f.png'),
                            Positioned(
                                height: 800,
                                width: 400,
                                child: Container(
                                  color: Colors.amber,
                                ).animate(target: _open ? 1 : 0).flipH(
                                      alignment: Alignment.centerLeft,
                                      end: -1,
                                    )),
                          ],
                        ).animate().flipH(begin: 0.5, end: 1))
                .rotate(begin: 0, end: -0.25)
                .scale(end: const Offset(0.5, 0.5)),
          ),
        ).animate(adapter: _adapter).scale(end: Offset(3, 3)),
      ],
    );
  }
}

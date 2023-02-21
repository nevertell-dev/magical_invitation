import 'package:flutter/material.dart';

class ScrollArea extends StatelessWidget {
  const ScrollArea({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 10,
        child: const Placeholder(color: Colors.transparent),
      ),
    );
  }
}

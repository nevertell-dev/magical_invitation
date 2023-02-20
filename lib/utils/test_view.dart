import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(height: size.height, child: const Placeholder()),
            Positioned(
                height: size.height * 2,
                width: size.width,
                child: const Placeholder()),
            SizedBox(height: size.height, child: const Placeholder()),
          ],
        ),
      ),
    );
  }
}

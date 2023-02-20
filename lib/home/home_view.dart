// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc.dart';

part './widgets/home_potrait.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (_controller.hasClients) {
          final bloc = context.read<HomeBloc>();
          bloc.add(HomeStarted(_controller));
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFECD7),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                if (state is HomeLoaded) ...[
                  HomeQuote(
                    adapter: state.quoteAdapter,
                    text:
                        'Lovers don\'t finally meet somewhere.\nThey\'re in each other all along.\n—Rumi',
                  ),
                  HomePotrait(
                    adapter: state.brideAdapter,
                    image: 'bride_potrait.png',
                    title: 'The Bride',
                    caption: 'The Daughter of Her Father and Her Mother',
                  ),
                  HomePotrait(
                    adapter: state.groomAdapter,
                    image: 'groom_potrait.png',
                    title: 'The Groom',
                    caption: 'The Son of His Father and His Mother',
                  )
                ],
                ScrollArea(controller: _controller),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HomeQuote extends StatelessWidget {
  const HomeQuote({
    Key? key,
    required this.adapter,
    required this.text,
  }) : super(key: key);

  final ScrollAdapter adapter;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 36,
            fontFamily: 'GreatVibes',
          )),
    )
        .animate(delay: 500.ms)
        .fadeIn(duration: 1000.ms, curve: Curves.easeInOut)
        .scale(begin: const Offset(1.2, 1.2))
        .animate(adapter: adapter)
        .scale(end: const Offset(0, 0))
        .fadeOut();
  }
}

class ScrollArea extends StatelessWidget {
  const ScrollArea({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      controller: controller,
      child: SizedBox(
        height: size.height * 10,
        child: const Placeholder(color: Colors.transparent),
      ),
    );
  }
}

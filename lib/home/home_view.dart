// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/scroll_area.dart';
import 'bloc/home_bloc.dart';
import 'widgets/home_potrait/cubit/potrait_cubit.dart';

part 'widgets/home_potrait/home_potrait.dart';

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
                    adapter: state.adapters[0],
                    text:
                        '"Lovers don\'t finally meet somewhere.\nThey\'re in each other all along.\n—Rumi"',
                  ),
                  HomePotrait(
                    adapter: state.adapters[1],
                    image: 'bride-potrait.png',
                    title: 'The Bride',
                    caption: 'The Daughter of Her Father and Her Mother',
                  ),
                  HomePotrait(
                    adapter: state.adapters[2],
                    image: 'groom-potrait.png',
                    title: 'The Groom',
                    caption: 'The Son of His Father and His Mother',
                  ),
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

  Widget _widget() => Center(
      child: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 36, fontFamily: 'GreatVibes')));

  @override
  Widget build(BuildContext context) => _widget()
      .animate(delay: 500.ms)
      .fadeIn(duration: 1000.ms, curve: Curves.easeInOut)
      .scale(begin: const Offset(1.2, 1.2))
      .animate(adapter: adapter)
      .scale(end: const Offset(0, 0))
      .fadeOut();
}

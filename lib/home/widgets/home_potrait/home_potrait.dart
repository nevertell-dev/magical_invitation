// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:magical_invitation/home/home_view.dart';

class HomePotrait extends StatelessWidget {
  const HomePotrait({
    Key? key,
    required this.adapter,
    required this.image,
    required this.title,
    required this.caption,
    required this.modifier,
  }) : super(key: key);

  final ScrollAdapter adapter;
  final String image;
  final String title;
  final String caption;

  final int modifier;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => PotraitCubit()
        ..potraitStarted(
          adapter.scrollController,
          adapter.begin,
          adapter.end,
        ),
      child: BlocBuilder<PotraitCubit, PotraitState>(
        builder: (context, state) {
          if (state is PotraitLoaded) {
            return Stack(
              fit: StackFit.expand,
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  width: size.width,
                  height: size.height * 2,
                  child: Image(
                    image: AssetImage('assets/images/$image'),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Column(
                  children: [
                    Text(title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          height: 0.8,
                          fontSize: 64,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F133A),
                        )),
                    const SizedBox(height: 16.0),
                    Text(caption,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          height: 0.8,
                          fontSize: 24,
                          fontFamily: 'Caveat',
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F133A),
                        )),
                  ],
                )
                    .animate(adapter: state.textAdapter)
                    .moveY(begin: 500, end: 250),
              ],
            )
                .animate(adapter: state.imageAdapter)
                .moveY(begin: size.height, end: -size.height * 0)
                .then()
                .scale(end: const Offset(0.3, 0.3))
                .fadeOut();
          }
          return const SizedBox();
        },
      ),
    );
  }
}

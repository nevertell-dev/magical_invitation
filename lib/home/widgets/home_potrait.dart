part of 'package:magical_invitation/home/home_view.dart';

class HomePotrait extends StatelessWidget {
  HomePotrait({
    Key? key,
    required this.image,
    required this.title,
    required this.caption,
    required ScrollAdapter adapter,
  })  : _textAdapter = ScrollAdapter(adapter.scrollController,
            begin: adapter.begin, end: adapter.end),
        _potraitAdapter = ScrollAdapter(adapter.scrollController,
            begin: adapter.begin, end: adapter.end),
        super(key: key);

  final String image;
  final String title;
  final String caption;

  final ScrollAdapter _textAdapter;
  final ScrollAdapter _potraitAdapter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
        height: size.height * 2,
        width: size.width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              'assets/images/$image',
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
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
                      fontFamily: 'GreatVibes',
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F133A),
                    )),
              ],
            ).animate(adapter: _textAdapter).moveY(begin: 500, end: 250),
          ],
        )
            .animate(adapter: _potraitAdapter)
            .moveY(begin: size.height, end: -size.height));
  }
}

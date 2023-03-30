// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magical_invitation/utils/const.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';
import 'package:just_audio_web/just_audio_web.dart';
import 'package:magical_invitation/utils/controller_helper.dart';
import 'package:magical_invitation/widgets/background_light.dart';
import 'package:magical_invitation/widgets/background_table.dart';
import 'package:magical_invitation/widgets/clock.dart';
import 'package:magical_invitation/widgets/date.dart';
import 'package:magical_invitation/widgets/deco_frame.dart';
import 'package:magical_invitation/widgets/end_screen.dart';
import 'package:magical_invitation/widgets/mail.dart';
import 'package:magical_invitation/widgets/overlay_text.dart';
import 'package:magical_invitation/widgets/potrait.dart';
import 'package:magical_invitation/widgets/story.dart';
import 'package:magical_invitation/widgets/timeline.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  JustAudioPlatform.instance = JustAudioPlugin();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final height = 12000.0;

  _body(ScrollController controller, Size size, double maxExtent) => [
        Positioned(
          width: size.width + 200,
          child: BackgroundTable(
            controller,
            maxExtent: maxExtent.at(0.2),
          ),
        ),
        MailBack(controller, maxExtent: maxExtent.at(0.2)),
        Positioned(
          width: size.width,
          right: 0,
          child: BackgroundLight(
            controller,
            maxExtent: maxExtent.at(0.2),
          ),
        ),
        Positioned(
          width: size.width,
          bottom: 0,
          child: OverlayText(
            controller,
            play: true,
            maxExtent: maxExtent.at(0.05),
            text: 'Tarik layar ke keatas secara perlahan',
          ),
        ),
        Potrait(
          controller,
          minExtent: maxExtent.at(0.19),
          maxExtent: maxExtent.at(0.29),
          image: 'potrait_bride',
          name: 'The Bride',
          subtitle: 'The daughter of her father and her mother',
        ),
        Potrait(
          controller,
          minExtent: maxExtent.at(0.23),
          maxExtent: maxExtent.at(0.33),
          image: 'potrait_groom',
          name: 'The Groom',
          subtitle: 'The son of his father and his mother',
        ),
        Positioned.fill(
          child: DecoFrame(
            controller,
            minExtent: maxExtent.at(0.05),
            maxExtent: maxExtent.at(0.5),
          ),
        ),
        Positioned.fill(
          child: Transform.scale(
            scaleX: -1,
            child: DecoFrame(
              controller,
              minExtent: maxExtent.at(0.05),
              maxExtent: maxExtent.at(0.5),
            ),
          ),
        ),
        Clock(
          controller,
          minExtent: maxExtent.at(0.4),
          maxExtent: maxExtent.at(0.6),
        ),
        const Text(
          'Membentuk kenangan\nyang akan terus\nmengalir dalam waktu.',
          textAlign: TextAlign.center,
          style: caveatStyle,
        )
            .animate(
              adapter: ScrollAdapter(
                controller,
                begin: maxExtent.at(0.4),
                end: maxExtent.at(0.6),
              ),
            )
            .fadeIn()
            .then()
            .fadeOut(),
        Positioned(
          width: size.width + 200,
          height: size.height,
          child: Story(
            controller,
            minExtent: maxExtent.at(0.27),
            maxExtent: maxExtent.at(0.45),
          ),
        ),
        Positioned(
          width: size.width,
          height: size.height,
          child: DateAnnouncement(
            controller,
            minExtent: maxExtent.at(0.5),
            maxExtent: maxExtent.at(0.7),
          ),
        ),
        Positioned(
          width: size.width,
          height: size.height,
          child: EndScreen(
            controller,
            minExtent: maxExtent.at(0.7),
            maxExtent: maxExtent,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magical Invitation',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      scrollBehavior: CustomScrollBehavior(),
      home: SafeArea(
          child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              body: Timeline(
                  height: height,
                  controller: ScrollController(),
                  children: (context, controller) {
                    final maxExtent = controller.hasClients
                        ? controller.position.maxScrollExtent
                        : height;
                    final size = MediaQuery.of(context).size;
                    return size.width < 600
                        ? _body(controller, size, maxExtent)
                        : const [
                            Center(
                              child: Text(
                                'Aplikasi ini dioptimalisasi untuk perangkat mobile dengan layar portrait\nJika ingin membukanya di desktop perkecil dulu windowsnya >>',
                              ),
                            )
                          ];
                  }))),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

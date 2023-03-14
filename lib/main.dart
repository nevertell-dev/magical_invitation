// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';
import 'package:just_audio_web/just_audio_web.dart';
import 'package:magical_invitation/utils/controller_helper.dart';
import 'package:magical_invitation/widgets/background_light.dart';
import 'package:magical_invitation/widgets/background_table.dart';
import 'package:magical_invitation/widgets/clock.dart';
import 'package:magical_invitation/widgets/mail.dart';
import 'package:magical_invitation/widgets/potrait.dart';
import 'package:magical_invitation/widgets/timeline.dart';
import 'package:magical_invitation/widgets/vinyl.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  JustAudioPlatform.instance = JustAudioPlugin();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                  height: 3000,
                  controller: ScrollController(),
                  children: (context, controller) {
                    final maxExtent = controller.position.maxScrollExtent;
                    return [
                      Positioned(
                        width: MediaQuery.of(context).size.width + 200,
                        child: BackgroundTable(
                          controller,
                          maxExtent: maxExtent.at(0.5),
                        ),
                      ),
                      MailBack(controller, maxExtent: maxExtent.at(0.5)),
                      Positioned.fill(
                        child: BackgroundLight(
                          controller,
                          maxExtent: maxExtent.at(0.5),
                        ),
                      ),
                      Potrait(
                        controller,
                        minExtent: maxExtent.at(0.5),
                        maxExtent: maxExtent.at(0.8),
                        image: 'potrait_groom',
                        name: 'The Groom',
                        subtitle: 'The son of his father and his mother',
                      ),
                      Potrait(
                        controller,
                        minExtent: maxExtent.at(0.6),
                        maxExtent: maxExtent.at(0.9),
                        image: 'potrait_bride',
                        name: 'The Bride',
                        subtitle: 'The daughter of her father and her mother',
                      ),
                      Clock(
                        controller,
                        minExtent: maxExtent.at(0.75),
                        maxExtent: maxExtent,
                      ),
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

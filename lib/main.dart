// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';
import 'package:just_audio_web/just_audio_web.dart';
import 'package:magical_invitation/utils/controller_helper.dart';
import 'package:magical_invitation/widgets/mail.dart';
import 'package:magical_invitation/widgets/scroller.dart';
import 'package:magical_invitation/widgets/vinyl.dart';

import 'firebase_options.dart';
import 'home/bloc/home_bloc.dart';

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
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
        ],
        child: SafeArea(
            child: Scaffold(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                body: Scroller(
                    height: 3000,
                    controller: ScrollController(),
                    children: (context, controller) => [
                          Positioned(
                            width: MediaQuery.of(context).size.width + 200,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/background_table.png',
                                  fit: BoxFit.cover,
                                ),
                                const Positioned(
                                    width: 400,
                                    height: 400,
                                    left: 50,
                                    top: 50,
                                    child: Vinyl()),
                              ],
                            )
                                .animate(
                                    adapter: ScrollAdapter(controller,
                                        end: controller.position.maxScrollExtent
                                            .at(0.2)))
                                .scaleXY(end: 0.9),
                          ),
                          MailBack(
                            controller: controller,
                            maxScrollExtent:
                                controller.position.maxScrollExtent,
                          ),
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/background_light.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ]))),
      ),
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

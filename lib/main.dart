// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magical_invitation/widgets/mail.dart';
import 'package:magical_invitation/widgets/scroller.dart';

import 'firebase_options.dart';
import 'home/bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
                backgroundColor: const Color.fromARGB(255, 6, 0, 61),
                body: Scroller(
                    height: 3000,
                    controller: ScrollController(),
                    children: (controller) => [
                          MailBack(
                            controller: controller,
                            maxScrollExtent:
                                controller.position.maxScrollExtent,
                          ),
                          // Letter(
                          //   controller: controller,
                          //   begin: 300,
                          //   maxScrollExtent:
                          //       controller.position.maxScrollExtent,
                          // )
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

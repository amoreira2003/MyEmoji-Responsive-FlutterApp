import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myemoji/pages/emojipage/home_display_page.dart';
import 'package:myemoji/pages/login/login_page.dart';

import 'auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    Auth auth = Auth();
    return StreamBuilder(
      stream: auth.authStateChanges,
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginPage();
        } else {
          return HomeDisplayPage(
            auth: auth,
          );
        }
      }),
    );
  }
}

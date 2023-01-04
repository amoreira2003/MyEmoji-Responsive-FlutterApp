import 'package:flutter/material.dart';
import '../signup/signin_page.dart';
import 'components/loginArea_widget.dart';
import '../emojipage/components/margin_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SignInPage(),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [Margin(), LogInArea(), Margin()],
          ),
        ));
  }
}

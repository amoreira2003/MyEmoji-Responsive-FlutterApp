import 'package:flutter/material.dart';
import 'package:myemoji/pages/emojipage/components/margin_widget.dart';
import 'components/signinArea_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [Margin(), SigninArea(), Margin()],
      ),
    ));
  }
}

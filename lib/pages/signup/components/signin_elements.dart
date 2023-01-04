import 'package:flutter/material.dart';

import '../../../responsive.dart';
import '../signin_form.dart';

class SignInElements extends StatelessWidget {
  const SignInElements({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Center(
            child: Text(
              "Sign-in",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Responsive.returnSize(context, 25, 33, 54),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Expanded(flex: 2, child: SignInPageForm()),
      ],
    );
  }
}

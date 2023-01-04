import 'package:flutter/material.dart';

import '../../../responsive.dart';
import '../login_form.dart';

class LogInAreaElements extends StatelessWidget {
  const LogInAreaElements({
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
              "Log-in",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Responsive.returnSize(context, 25, 33, 54),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Expanded(flex: 2, child: LoginForm()),
      ],
    );
  }
}

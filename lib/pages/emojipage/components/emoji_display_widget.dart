import 'package:flutter/material.dart';

import '../../../auth.dart';
import '../../../design_choices.dart';
import '../../../responsive.dart';
import 'emoji_display_elements.dart';

class EmojiDisplayArea extends StatelessWidget {
  EmojiDisplayArea({super.key, required this.auth});

  Auth auth;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 4,
      child: Container(
        width: width,
        decoration: const BoxDecoration(
          color: grayColor,
        ),
        child: Center(
          child: Container(
              width: Responsive.returnSize(context, 400, 550, 700),
              height: Responsive.returnSize(context, 400, 550, 700),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        spreadRadius: 1,
                        blurRadius: 4,
                        color: Color.fromARGB(25, 0, 0, 0))
                  ]),
              child: EmojiDisplayElements(
                auth: auth,
              )),
        ),
      ),
    );
  }
}

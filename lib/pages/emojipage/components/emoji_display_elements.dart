import 'package:flutter/material.dart';

import '../../../auth.dart';
import '../../../responsive.dart';

class EmojiDisplayElements extends StatelessWidget {
  EmojiDisplayElements({super.key, required this.auth});

  Auth auth;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "There is your emoji",
          style: TextStyle(
              color: Colors.black,
              fontSize: Responsive.returnSize(context, 25, 33, 54),
              fontWeight: FontWeight.bold),
        ),
        Container(
          width: Responsive.returnSize(context, 250, 300, 400),
          height: Responsive.returnSize(context, 250, 300, 400),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Center(
            child: FutureBuilder(
                future: auth.getAccountEmoji(auth.currentUser!.email),
                builder: (context, snapshot) => snapshot.hasData
                    ? Text(
                        snapshot.requireData,
                        style: TextStyle(
                            fontSize:
                                Responsive.returnSize(context, 60, 80, 100)),
                      )
                    : const Text("?")),
          ),
        ),
        Text(
          "We won't charge it back, your emoji, your problem",
          style:
              TextStyle(fontSize: Responsive.returnSize(context, 15, 20, 28)),
        ),
        TextButton(
            onPressed: () => signOut(),
            child: Text(
              "Sing-out",
              style: TextStyle(
                  fontSize: Responsive.returnSize(context, 15, 20, 28)),
            ))
      ],
    );
  }
}

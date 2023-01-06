import 'package:flutter/material.dart';

import '../../auth.dart';
import '../../constants.dart';
import '../../responsive.dart';

class HomeDisplayPage extends StatelessWidget {
  HomeDisplayPage({Key? key, required this.auth}) : super(key: key);

  Auth auth;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              color: grayColor,
              height: Responsive.returnSize(context, 5, 10, 20),
            ),
            Expanded(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "There is your emoji",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                Responsive.returnSize(context, 25, 33, 54),
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: Responsive.returnSize(context, 250, 300, 400),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Center(
                          child: FutureBuilder(
                              future:
                                  auth.getAccountEmoji(auth.currentUser!.email),
                              builder: (context, snapshot) => snapshot.hasData
                                  ? Text(
                                      snapshot.requireData,
                                      style: TextStyle(
                                          fontSize: Responsive.returnSize(
                                              context, 30, 40, 100)),
                                    )
                                  : const Text("")),
                        ),
                      ),
                      Text(
                        "We won't charge it back, your emoji, your problem",
                        style: TextStyle(
                            fontSize:
                                Responsive.returnSize(context, 15, 20, 28)),
                      ),
                      TextButton(
                          onPressed: () => signOut(),
                          child: Text(
                            "Sing-out",
                            style: TextStyle(
                                fontSize:
                                    Responsive.returnSize(context, 15, 20, 28)),
                          ))
                    ],
                  ),
                )),
              ),
            ),
            Container(
              width: width,
              color: grayColor,
              height: Responsive.returnSize(context, 5, 10, 20),
            ),
          ],
        ),
      ),
    );
  }
}

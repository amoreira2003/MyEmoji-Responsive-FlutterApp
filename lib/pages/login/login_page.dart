import 'package:flutter/material.dart';
import '../../design_choices.dart';
import '../../responsive.dart';
import '../signup/signin_page.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: const SignInPage(),
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
                    height: Responsive.returnSize(context, 500, 550, 700),
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
                        Expanded(
                          child: Center(
                            child: Text(
                              "Log-in",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Responsive.returnSize(
                                      context, 25, 33, 54),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const Expanded(flex: 2, child: LoginForm()),
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
        ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth.dart';
import '../../responsive.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormFormState();
}

class _LoginFormFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? errorMessage = '';
  bool isVisible = false;
  bool showPassWordIcon = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  bool validateEmail(String? input) {
    input = input ?? "";
    final regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regExp.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    passwordFocusNode.addListener(
      () {
        if (passwordFocusNode.hasFocus) {
          setState(() => showPassWordIcon = true);
        } else {
          setState(() => showPassWordIcon = false);
        }
      },
    );

    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  controller: emailController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      floatingLabelStyle: TextStyle(),
                      hintText: "Use your email",
                      labelText: "Email"),
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "You need to type an email";
                    }

                    if (!validateEmail(value)) {
                      return "Invalid Email Address";
                    }

                    return null;
                  },
                ),
              ),
              TextFormField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                maxLines: 1,
                obscureText: !isVisible,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Use your password to sing-in",
                    labelText: "Password",
                    suffix: showPassWordIcon
                        ? IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() => isVisible = !isVisible);
                            },
                            icon: Icon(isVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined))
                        : null),
                validator: (value) {
                  if (value == "" || value == null) {
                    return "You need to type a password";
                  }

                  if (value.length <= 8) {
                    return "Your password must be longer than 8 charactes";
                  }

                  return null;
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      RawMaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signInWithEmailAndPassword();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.lock_open_outlined),
                              Text(" Log-in")
                            ],
                          )),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Text("Sign-in Instead"),
                  ),
                  Text(
                    errorMessage ?? "",
                    style: const TextStyle(),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

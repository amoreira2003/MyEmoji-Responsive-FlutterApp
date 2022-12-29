import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth.dart';

class SignInPageForm extends StatefulWidget {
  const SignInPageForm({super.key});

  @override
  State<SignInPageForm> createState() => _SignInPageFormState();
}

class _SignInPageFormState extends State<SignInPageForm> {
  final _formKey = GlobalKey<FormState>();

  String? errorMessage = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void setErrorMessage(String? error) => setState(() => errorMessage = error);

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        setErrorMessage(e.message);
      });
    }
  }

  bool validateEmail(String? input) {
    input = input ?? "";
    final regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regExp.hasMatch(input);
  }

  Future<bool> validateEmailInUse(String input) async {
    try {
      List<String> emailList =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(input);
      return emailList.isEmpty;
    } on FirebaseAuthException catch (e) {
      setErrorMessage(e.toString());
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(),
                  hintText: "Use your email to sing-in",
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
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Use your password to sing-in",
                labelText: "Password"),
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
              RawMaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (!await validateEmailInUse(emailController.text)) {
                      return setErrorMessage("Email already in use");
                    }
                    await createUserWithEmailAndPassword();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.login_outlined),
                    Text("Register")
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Log-in Instead"),
              ),
              Text(errorMessage ?? "")
            ],
          ),
        ]),
      ),
    );
  }
}

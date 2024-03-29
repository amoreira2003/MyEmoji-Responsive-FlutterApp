import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth.dart';
import '../../constants.dart';

class SignInPageForm extends StatefulWidget {
  const SignInPageForm({super.key});

  @override
  State<SignInPageForm> createState() => _SignInPageFormState();
}

class _SignInPageFormState extends State<SignInPageForm> {
  final _formKey = GlobalKey<FormState>();

  String? errorMessage = '';
  bool isVisible = false;
  bool showPassWordIcon = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();

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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: TextFormField(
              controller: emailController,
              maxLines: 1,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(),
                  hintText: "Use your email to sing-in",
                  labelText: "Email"),
              validator: (value) {
                return validateInputEmail(value);
              },
            ),
          ),
          TextFormField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            maxLines: 1,
            obscureText: !isVisible,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
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
              return validatePassword(value);
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

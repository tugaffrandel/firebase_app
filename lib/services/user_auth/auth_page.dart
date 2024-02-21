import 'package:flutter/material.dart';
import 'package:todo_app_firebase_login/screens/log_in_screen.dart';
import 'package:todo_app_firebase_login/screens/sign_up_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool a = true;
  void to() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return LogInScreen(to);
    } else {
      return SignUpScreen(to);
    }
  }
}

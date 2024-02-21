import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_firebase_login/bloc/bloc/authbloc_bloc.dart';
import 'package:todo_app_firebase_login/widgets/log_in_image.dart';
import 'package:todo_app_firebase_login/widgets/log_in_sign_up_button.dart';
import 'package:todo_app_firebase_login/widgets/submit_button.dart';
import 'package:todo_app_firebase_login/widgets/textformfield.dart';

class LogInScreen extends StatefulWidget {
  final VoidCallback show;
  const LogInScreen(this.show, {super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });

    super.initState();
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const LogInImage(),
                const SizedBox(
                  height: 50,
                ),
                TextFormFieldWidget(
                  formKey: ValueKey(email),
                  textValidator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please Enter valid Email';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      email.text = value!;
                    });
                  },
                  controller: email,
                  focusNode: _focusNode1,
                  hintText: 'Email',
                  obscureText: false,
                  icon: Icons.email,
                ),
                TextFormFieldWidget(
                  formKey: ValueKey(password),
                  controller: password,
                  textValidator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Password';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password.text = value!;
                    });
                  },
                  focusNode: _focusNode2,
                  hintText: 'Password',
                  obscureText: true,
                  icon: Icons.password,
                ),
                const SizedBox(
                  height: 20,
                ),
                SubmitButton(
                  submit: () async {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(LogInUser(
                          email: email.text, password: password.text));
                    }
                  },
                  name: 'Log In',
                ),
                const SizedBox(
                  height: 10,
                ),
                LogInSignUpButton(
                  onClickName: 'Sign Up',
                  onTap: widget.show,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

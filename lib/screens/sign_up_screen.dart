import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app_firebase_login/bloc/bloc/authbloc_bloc.dart';
import 'package:todo_app_firebase_login/widgets/log_in_image.dart';
import 'package:todo_app_firebase_login/widgets/log_in_sign_up_button.dart';
import 'package:todo_app_firebase_login/widgets/submit_button.dart';
import 'package:todo_app_firebase_login/widgets/textformfield.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback show;
  const SignUpScreen(this.show, {super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

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
    super.initState();
    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User is created sucessfully')));
        } else if (state is AuthenticationFailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: Scaffold(
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
                    formKey: ValueKey(_userName.text),
                    textValidator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Full Name';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _userName.text = value!;
                      });
                    },
                    controller: _userName,
                    focusNode: _focusNode1,
                    hintText: 'Username',
                    obscureText: false,
                    icon: Icons.person,
                  ),
                  TextFormFieldWidget(
                    formKey: ValueKey(_email),
                    textValidator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please Enter valid Email';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _email.text = value!;
                      });
                    },
                    controller: _email,
                    focusNode: _focusNode2,
                    hintText: 'Email',
                    obscureText: false,
                    icon: Icons.email,
                  ),
                  TextFormFieldWidget(
                    formKey: ValueKey(_password),
                    controller: _password,
                    textValidator: (value) {
                      if (value!.length < 6) {
                        return 'Please Enter Password of min length 6';
                      } else if (_password.text != _confirmPassword.text) {
                        return 'Password Does not Match';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _password.text = value!;
                      });
                    },
                    focusNode: _focusNode3,
                    hintText: 'Password',
                    obscureText: true,
                    icon: Icons.password,
                  ),
                  TextFormFieldWidget(
                    formKey: ValueKey(_confirmPassword),
                    textValidator: (value) {
                      if (value!.length < 6) {
                        return 'Please Enter Password of min length 6';
                      } else if (_password.text != _confirmPassword.text) {
                        return 'Password Does not Match';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _confirmPassword.text = value!;
                      });
                    },
                    controller: _confirmPassword,
                    focusNode: _focusNode4,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    icon: Icons.password,
                  ),
                  LogInSignUpButton(
                    onClickName: 'Log In',
                    onTap: widget.show,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SubmitButton(
                    submit: () async {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SignUpUser(
                            name: _userName.text,
                            email: _email.text,
                            password: _password.text));
                      }
                    },
                    name: 'Sign Up',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

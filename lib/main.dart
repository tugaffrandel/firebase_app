import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_firebase_login/bloc/bloc/authbloc_bloc.dart';
import 'package:todo_app_firebase_login/firebase_options.dart';
import 'package:todo_app_firebase_login/screens/homescreen.dart';
import 'package:todo_app_firebase_login/services/auth_flow.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => const HomeScreen(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              primary: const Color(0xff18DAA3),
              secondary: const Color(0xffc5c5c5),
              background: Colors.grey.shade100),
        ),
        home: const AuthenticationFlow(),
      ),
    );
  }
}

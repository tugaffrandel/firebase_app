import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todo_app_firebase_login/services/user_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('User Logged In')));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                AuthServices auth = AuthServices();

                await auth.signOut();
              },
              icon: const Icon(Icons.leave_bags_at_home))
        ],
      ),
    );
  }
}

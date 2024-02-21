import 'package:flutter/material.dart';

class LogInImage extends StatelessWidget {
  const LogInImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Image.asset(
          'assets/7.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function()? submit;
  final String name;
  const SubmitButton({super.key, required this.name, required this.submit});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: submit,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        child: Text(
          name,
          style: const TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

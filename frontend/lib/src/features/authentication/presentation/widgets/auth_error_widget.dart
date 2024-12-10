import 'package:flutter/material.dart';

class AuthErrorWidget extends StatelessWidget {
  final String errorMessage;

  const AuthErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}

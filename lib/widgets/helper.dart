import 'package:flutter/material.dart';

void showError(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromRGBO(211, 47, 47, 1),
      duration: const Duration(seconds: 2),
      content: Text(
        error,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

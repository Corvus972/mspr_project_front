import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: Colors.blue,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 1),
    action: SnackBarAction(
        label: 'Fermer',
        textColor: Colors.white,
        onPressed: () {
          print('Fermer');
        }),
  ));
}

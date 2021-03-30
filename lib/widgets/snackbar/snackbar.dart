import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, Color customColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: customColor,
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

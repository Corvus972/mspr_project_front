import 'package:flutter/material.dart';

class MsgNotif extends StatelessWidget {
  const MsgNotif({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          onPrimary: Colors.white,
          onSurface: Colors.grey,
        ),
        onPressed: () {
          final snackBar = SnackBar(
            elevation: 1000,
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Pas assez de stock',
              style: TextStyle(color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Fermer',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}

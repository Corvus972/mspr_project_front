import 'package:flutter/material.dart';
import 'package:mspr_project/screens/checkout/checkout.dart';
import 'package:mspr_project/screens/home/home.dart';
import 'package:mspr_project/screens/profile/profile.dart';

class Alert extends StatelessWidget {
  const Alert({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text('Promotions'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Entrez vos codes promos'),
          ),
          Center(
            child: TextButton(
                onPressed: () {},
                child: Text('Valider'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.teal,
                  onSurface: Colors.grey,
                  textStyle: TextStyle(
                      color: Colors.black, fontStyle: FontStyle.italic),
                )),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Icon(Icons.close),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mspr_project/repository/cart_repository.dart';
import 'package:mspr_project/screens/checkout/checkout.dart';
import 'package:mspr_project/screens/home/home.dart';
import 'package:mspr_project/screens/profile/profile.dart';

class Alert extends StatelessWidget {
  final Map text;
  const Alert({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(text["title"]),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: text["placeHolder"]),
            ),
          ),
          Center(
            child: TextButton(
                onPressed: () {
                  cartRepository.applyDiscount('dd');
                },
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
          textColor: Theme.of(context).errorColor,
          child: Text("Fermer"),
        ),
      ],
    );
  }
}

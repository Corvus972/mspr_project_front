import 'package:flutter/material.dart';
import 'package:mspr_project/repository/cart_repository.dart';

class Alert extends StatefulWidget {
  final Map text;
  const Alert({Key key, @required this.text}) : super(key: key);

  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(widget.text["title"]),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.text["placeHolder"]),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            /* SVX99XV6 */
            var text = myController.text;
            if (text != "") {
              cartRepository.applyDiscount(text);
            }
          },
          textColor: Theme.of(context).primaryColor,
          child: Text("Valider"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).errorColor,
          child: Text("Fermer"),
        )
      ],
    );
  }
}

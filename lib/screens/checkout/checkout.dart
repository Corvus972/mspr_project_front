import 'package:flutter/material.dart';
import 'package:mspr_project/repository/cart_repository.dart';
import 'package:mspr_project/widgets/alert/alert.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';
import 'package:mspr_project/screens/checkout/checkout_bloc.dart';
import 'package:flutter/services.dart';
import 'package:mspr_project/widgets/notification/msg_notif.dart';

class Checkout extends StatefulWidget {
  static String routeName = "/checkout";

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var identifier = {"key1": "value1"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: StreamBuilder(
                stream: cartRepository.getStream,
                initialData: cartRepository.totalSum,
                builder: (context, snapshot2) {
                  return cartRepository.totalSum > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                              Text(
                                  'Total: ${cartRepository.totalSum.toString()} €'),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Alert(
                                      text: {
                                        "title": "Promotions",
                                        "placeHolder":
                                            "Entrez vos codes promos",
                                      },
                                    ),
                                  );
                                },
                                child: Text('Code Promo'),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.teal,
                                  onSurface: Colors.grey,
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),
                                ),
                              )
                            ])
                      : Text('Panier');
                })),
        body: StreamBuilder(
          stream: cartRepository.getStream,
          initialData: cartRepository.allItems,
          builder: (context, snapshot) {
            return snapshot.data.length > 0
                ? Column(
                    children: <Widget>[
                      /// The [checkoutListBuilder] has to be fixed
                      /// in an expanded widget to ensure it
                      /// doesn't occupy the whole screen and leaves
                      /// room for the the RaisedButton
                      Expanded(child: checkoutListBuilder(snapshot.data)),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: RaisedButton.icon(
                          color: Colors.green,
                          onPressed: () {
                            print('ta mere');
                          },
                          label: Text("Commander",
                              style: TextStyle(color: Colors.white)),
                          icon: Icon(Icons.check_circle_outline,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 60)
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                                "Vous n'avez pas de produits dans votre panier ")),
                        Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator()),
                      ]);
            /*     CircularProgressIndicator(), */
          },
        ),
        bottomNavigationBar: BottomNav());
  }
  
}

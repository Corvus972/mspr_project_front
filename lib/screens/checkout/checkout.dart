import 'package:flutter/material.dart';
import 'package:mspr_project/repository/cart_repository.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';
import 'package:mspr_project/screens/checkout/checkout_bloc.dart';
import 'package:flutter/services.dart';

class Checkout extends StatefulWidget {
  String titlePanier = "Panier";
  static String routeName = "/checkout";

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String changetTitle() {
    double tot = cartRepository.totalCart();
    if (tot > 0) {
      widget.titlePanier = 'Total: ${tot.toString()} €';
    }
    return widget.titlePanier;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(changetTitle())),
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
                      Expanded(child: checkoutListBuilder(snapshot)),
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
                : Center(
                    child:
                        Text("Vous n'avez pas de produits dans votre panier "),
                  );
          },
        ),
        bottomSheet: BottomNav());
  }
}

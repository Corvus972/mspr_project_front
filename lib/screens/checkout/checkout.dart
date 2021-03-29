import 'package:flutter/material.dart';
import 'package:mspr_project/provider/auth.dart';
import 'package:mspr_project/repository/cart_repository.dart';
import 'package:mspr_project/screens/checkout/order_failed.dart';
import 'package:mspr_project/screens/checkout/order_success.dart';
import 'package:mspr_project/screens/login/login.dart';
import 'package:mspr_project/widgets/alert/alert.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';
import 'package:mspr_project/screens/checkout/checkout_bloc.dart';

class CheckoutPage extends StatefulWidget {
  static String routeName = "/checkout";

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<CheckoutPage> {
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
                      StreamBuilder(
                        stream: authService.getStream,
          initialData: authService.isLogged,
          builder: (context, snapshot) {
            print(snapshot.data);
            return snapshot.data == true
                ? FractionallySizedBox(
                          widthFactor: 0.9,
                          child: RaisedButton.icon(
                            color: Colors.green,
                            onPressed: () async{
                              var response = await cartRepository.sendOrder();
                              if(response){
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OrderSuccessPage()),
                              );
                              }else{
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OrderFailedPage()),
                              );
                              }
                            },
                            label: Text("Commander",
                                style: TextStyle(color: Colors.white)),
                            icon: Icon(Icons.check_circle_outline,
                                color: Colors.white),
                          ),
                        )
                        :
                       FractionallySizedBox(
                          widthFactor: 0.9,
                          child: RaisedButton.icon(
                            color: Colors.orange,
                            onPressed: () {
                              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                            },
                            label: Text("Veuillez vous connecter",
                                style: TextStyle(color: Colors.white)),
                            icon: Icon(Icons.check_circle_outline,
                                color: Colors.white),
                          ),
                        );
          }),
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

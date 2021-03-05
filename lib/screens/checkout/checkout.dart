import 'package:flutter/material.dart';
import 'package:mspr_project/repository/cart_repository.dart';
import 'package:mspr_project/widgets/bottom_nav/bottom_nav.dart';

class Checkout extends StatelessWidget {
  static String routeName = "/checkout";
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Panier')),
        body: StreamBuilder(
          stream: cartRepository.getStream,
          initialData: cartRepository.allItems,
          builder: (context, snapshot) {
            return snapshot.data['cart_items'].length > 0
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

Widget checkoutListBuilder(snapshot) {
  return ListView.builder(
    itemCount: snapshot.data["cart_items"].length,
    itemBuilder: (BuildContext context, i) {
      final cartList = snapshot.data["cart_items"];
      return ListTile(
        leading: Image.network(
          cartList[i].image,
          fit: BoxFit.scaleDown,
          width: 40,
          height: 40,
        ),
        title: Text(cartList[i].productName),
        subtitle: Text("${cartList[i].productPrice} €"),
        trailing: IconButton(
          icon: Icon(Icons.remove_shopping_cart, color: Colors.red),
          onPressed: () {
            cartRepository.removeFromCart(cartList[i]);
          },
        ),
        onTap: () {},
      );
    },
  );
}

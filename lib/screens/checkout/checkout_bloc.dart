import 'package:flutter/material.dart';
import 'package:mspr_project/models/cart.dart';
import 'package:mspr_project/repository/cart_repository.dart';

Widget checkoutListBuilder(snapshot) {
  return ListView.builder(
    itemCount: snapshot.length,
    itemBuilder: (BuildContext context, i) {
      final cartList = snapshot;
      return Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // A Row for the top
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Image.network(
                  cartList[i].product.image,
                  fit: BoxFit.scaleDown,
                  width: 50,
                  height: 50,
                ),
                Text(cartList[i].product.productName),
                Text('${cartList[i].product.productPrice}€'),
              ]),
              //For the Line
              Divider(height: 10, thickness: 5),
              // A Row for each Row in the table from now on
              //VerticalDivider for the vertical line, just as Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _decrementButton(cartList[i]),
                  Text(
                    '${cartList[i].quantity}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  _incrementButton(cartList[i])
                ],
                // be carefull with the $ since it's used to put variables
                // into strings, eg Text('Name : $name ')
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Total: ${cartList[i].totalByProduct}€',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_shopping_cart, color: Colors.red),
                    onPressed: () {
                      cartRepository.removeFromCart(cartList[i]);
                    },
                  ),
                ],
                // be carefull with the $ since it's used to put variables
                // into strings, eg Text('Name : $name ')
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _incrementButton(Cart item) {
  return IconButton(
    onPressed: () {
      print(item);
      cartRepository.increase(item);
    },
    icon: Icon(Icons.add, color: Colors.black),
    highlightColor: Colors.pink,
  );
}

Widget _decrementButton(Cart item) {
  return IconButton(
    onPressed: () {
      cartRepository.decrease(item);
    },
    icon: Icon(Icons.remove, color: Colors.black),
    highlightColor: Colors.pink,
  );
}

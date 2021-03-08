import 'package:flutter/material.dart';
import 'package:mspr_project/repository/cart_repository.dart';

Widget checkoutListBuilder(snapshot) {
  return ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, i) {
      final cartList = snapshot.data;
      return ListTile(
        leading: Image.network(
          cartList[i].product.image,
          fit: BoxFit.scaleDown,
          width: 40,
          height: 40,
        ),
        title: Text(cartList[i].product.productName),
        /*  subtitle: Text("${cartList[i].productPrice} €"), */
        subtitle: Text("quantité: ${cartList[i].quantity} "),
        /* subtitle: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly]), */
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

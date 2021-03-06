import 'dart:async';

import 'package:mspr_project/models/product.dart';

class CartProvider {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  final List<Product> allItems = [];

  void addToCart(item) {
    final index = allItems.indexWhere((element) => element.id == item.id);
    if (index < 0) {
      item.quantity = 1;
      allItems.add(item);
    } else {
      allItems[index].quantity++;
      print("id: " + allItems[index].id.toString());
    }
    print("quantity: " + item.quantity.toString());
    cartStreamController.sink.add(allItems);
    /* print('item: ' + item.productName); */
    /*   for (var i = 0; i < allItems['cart_items'].length; i++) {
      if (allItems['cart_items'][i].id == item.id) {
        print('Using loop: ${allItems['cart_items'][i].productName}');

        // Found the person, stop the loop
        return;
      }
    } */

    /* print(allItems['cart_items']); */
  }

  void removeFromCart(item) {
    allItems.remove(item);
    cartStreamController.sink.add(allItems);
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final cartRepository = CartProvider();
